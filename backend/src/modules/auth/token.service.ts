import { randomUUID } from 'node:crypto';
import { HttpStatus, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { AppException } from '../../common/errors/app.exception';
import { HashingService } from '../../common/crypto/hashing.service';
import { PrismaService } from '../../common/prisma/prisma.service';
import { Env } from '../../config/env.schema';
import { AuditService } from '../audit/audit.service';

export interface TokenPair {
  accessToken: string;
  refreshToken: string;
  /** Segundos de vida del access token. */
  expiresIn: number;
}

interface TokenSubject {
  id: string;
  subjectId: string;
  role: string;
}

/**
 * Access token JWT de vida corta + refresh token opaco y rotativo (docs/05).
 * Cada refresh se usa una sola vez; si llega uno ya rotado, se asume robo y
 * se revoca toda su familia.
 */
@Injectable()
export class TokenService {
  private readonly accessTtl: number;
  private readonly refreshTtlMs: number;

  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly hashing: HashingService,
    private readonly audit: AuditService,
    config: ConfigService<Env, true>,
  ) {
    this.accessTtl = config.get('JWT_ACCESS_TTL_SECONDS', { infer: true });
    this.refreshTtlMs =
      config.get('REFRESH_TTL_DAYS', { infer: true }) * 24 * 60 * 60 * 1000;
  }

  /** Inicia una nueva familia de refresh tokens (login, registro). */
  async issue(user: TokenSubject, deviceInfo?: string): Promise<TokenPair> {
    return this.createPair(user, randomUUID(), deviceInfo);
  }

  async rotate(refreshToken: string): Promise<TokenPair> {
    const tokenHash = this.hashing.hashToken(refreshToken);
    const stored = await this.prisma.refreshToken.findUnique({
      where: { tokenHash },
      include: {
        user: {
          select: { id: true, subjectId: true, role: true, status: true },
        },
      },
    });
    if (!stored || stored.revokedAt || stored.user.status !== 'active') {
      throw invalidToken();
    }

    // Marcar como usado solo si nadie lo usó antes (evita la carrera de dos
    // rotaciones simultáneas con el mismo token).
    const { count } = await this.prisma.refreshToken.updateMany({
      where: { id: stored.id, rotatedAt: null },
      data: { rotatedAt: new Date() },
    });
    if (count === 0) {
      await this.revokeFamily(stored.familyId);
      await this.audit.record({
        action: 'auth.refresh_reuse_detected',
        actorSubjectId: stored.user.subjectId,
        resourceType: 'refresh_token_family',
        resourceId: stored.familyId,
      });
      throw new AppException(
        'REFRESH_REUSED',
        'La sesión se cerró por seguridad',
        HttpStatus.UNAUTHORIZED,
      );
    }
    if (stored.expiresAt.getTime() <= Date.now()) throw invalidToken();

    return this.createPair(
      stored.user,
      stored.familyId,
      stored.deviceInfo ?? undefined,
    );
  }

  /** Cierra la sesión de un dispositivo (su familia de tokens). */
  async revokeByToken(refreshToken: string): Promise<string | null> {
    const stored = await this.prisma.refreshToken.findUnique({
      where: { tokenHash: this.hashing.hashToken(refreshToken) },
      select: { familyId: true, userId: true },
    });
    if (!stored) return null;
    await this.revokeFamily(stored.familyId);
    return stored.userId;
  }

  /** Cierra todas las sesiones e invalida los access tokens ya emitidos. */
  async revokeAll(userId: string): Promise<void> {
    const now = new Date();
    await this.prisma.$transaction([
      this.prisma.refreshToken.updateMany({
        where: { userId, revokedAt: null },
        data: { revokedAt: now },
      }),
      this.prisma.user.update({
        where: { id: userId },
        data: { tokensValidAfter: now },
      }),
    ]);
  }

  private async revokeFamily(familyId: string): Promise<void> {
    await this.prisma.refreshToken.updateMany({
      where: { familyId, revokedAt: null },
      data: { revokedAt: new Date() },
    });
  }

  private async createPair(
    user: TokenSubject,
    familyId: string,
    deviceInfo?: string,
  ): Promise<TokenPair> {
    const refreshToken = this.hashing.newToken();
    await this.prisma.refreshToken.create({
      data: {
        userId: user.id,
        tokenHash: this.hashing.hashToken(refreshToken),
        familyId,
        deviceInfo,
        expiresAt: new Date(Date.now() + this.refreshTtlMs),
      },
    });
    const accessToken = await this.jwt.signAsync(
      { sub: user.id, sid: user.subjectId, role: user.role },
      { expiresIn: this.accessTtl },
    );
    return { accessToken, refreshToken, expiresIn: this.accessTtl };
  }
}

function invalidToken(): AppException {
  return new AppException(
    'INVALID_TOKEN',
    'Sesión no válida',
    HttpStatus.UNAUTHORIZED,
  );
}
