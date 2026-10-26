import { randomBytes } from 'node:crypto';
import { HttpStatus, Injectable } from '@nestjs/common';
import * as argon2 from 'argon2';
import { AppException } from '../../common/errors/app.exception';
import { HashingService } from '../../common/crypto/hashing.service';
import { PrismaService } from '../../common/prisma/prisma.service';
import { Prisma } from '../../generated/prisma/client';
import { AuditService } from '../audit/audit.service';
import { LoginDto, RegisterDto } from './dto/auth.dto';
import { TokenPair, TokenService } from './token.service';

/** Edad mínima del MVP (docs/12; ADR-0006). */
export const MIN_AGE = 18;

/** Intentos fallidos por cuenta antes de bloquear temporalmente el login. */
const MAX_FAILED_LOGINS = 10;
const FAILED_LOGIN_WINDOW_MS = 15 * 60 * 1000;

/** argon2id con parámetros recomendados por OWASP (2024+). */
export const ARGON2_OPTIONS = {
  type: argon2.argon2id,
  memoryCost: 19_456,
  timeCost: 2,
  parallelism: 1,
} as const;

interface Meta {
  ip?: string;
  userAgent?: string;
}

@Injectable()
export class AuthService {
  /** Hash de una contraseña aleatoria descartada: solo iguala tiempos de respuesta. */
  private readonly dummyHash = argon2.hash(
    randomBytes(32).toString('hex'),
    ARGON2_OPTIONS,
  );

  constructor(
    private readonly prisma: PrismaService,
    private readonly tokens: TokenService,
    private readonly hashing: HashingService,
    private readonly audit: AuditService,
  ) {}

  async register(dto: RegisterDto, meta: Meta): Promise<TokenPair> {
    // Solo hay año de nacimiento: quien cumple 18 este año pasa, junto con la
    // autodeclaración explícita (ageConfirmed). Ver docs/12.
    if (new Date().getFullYear() - dto.birthYear < MIN_AGE) {
      throw new AppException(
        'UNDERAGE',
        'SentIA es solo para mayores de 18 años',
        HttpStatus.FORBIDDEN,
      );
    }

    const passwordHash = await argon2.hash(dto.password, ARGON2_OPTIONS);
    let user: { id: string; subjectId: string; role: string };
    try {
      user = await this.prisma.user.create({
        data: {
          email: dto.email,
          passwordHash,
          birthYear: dto.birthYear,
          profile: { create: {} },
        },
        select: { id: true, subjectId: true, role: true },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new AppException(
          'EMAIL_TAKEN',
          'Ya existe una cuenta con ese correo',
          HttpStatus.CONFLICT,
        );
      }
      throw error;
    }

    await this.audit.record({
      action: 'auth.register',
      actorSubjectId: user.subjectId,
      resourceType: 'user',
      resourceId: user.subjectId,
      ipHash: this.hashing.hashIp(meta.ip),
    });
    return this.tokens.issue(user, meta.userAgent);
  }

  async login(dto: LoginDto, meta: Meta): Promise<TokenPair> {
    const ipHash = this.hashing.hashIp(meta.ip);
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email },
      select: {
        id: true,
        subjectId: true,
        role: true,
        status: true,
        passwordHash: true,
      },
    });

    if (user && (await this.isLocked(user.subjectId))) {
      throw new AppException(
        'ACCOUNT_LOCKED',
        'Demasiados intentos. Intenta de nuevo en unos minutos.',
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }

    // Se verifica contra un hash ficticio si no existe la cuenta, para que el
    // tiempo de respuesta no revele qué correos están registrados.
    const valid = await argon2
      .verify(user?.passwordHash ?? (await this.dummyHash), dto.password)
      .catch(() => false);

    if (!user || !valid || user.status !== 'active') {
      await this.audit.record({
        action: 'auth.login_failed',
        actorSubjectId: user?.subjectId ?? null,
        resourceType: 'session',
        ipHash,
      });
      throw new AppException(
        'INVALID_CREDENTIALS',
        'Correo o contraseña incorrectos',
        HttpStatus.UNAUTHORIZED,
      );
    }

    await this.audit.record({
      action: 'auth.login',
      actorSubjectId: user.subjectId,
      resourceType: 'session',
      ipHash,
    });
    return this.tokens.issue(user, meta.userAgent);
  }

  async logout(refreshToken: string): Promise<void> {
    const userId = await this.tokens.revokeByToken(refreshToken);
    if (!userId) return;
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { subjectId: true },
    });
    await this.audit.record({
      action: 'auth.logout',
      actorSubjectId: user?.subjectId ?? null,
      resourceType: 'session',
    });
  }

  async logoutAll(userId: string, subjectId: string): Promise<void> {
    await this.tokens.revokeAll(userId);
    await this.audit.record({
      action: 'auth.logout_all',
      actorSubjectId: subjectId,
      resourceType: 'session',
    });
  }

  private async isLocked(subjectId: string): Promise<boolean> {
    const since = new Date(Date.now() - FAILED_LOGIN_WINDOW_MS);
    const failures = await this.prisma.auditLog.count({
      where: {
        actorSubjectId: subjectId,
        action: 'auth.login_failed',
        at: { gte: since },
      },
    });
    return failures >= MAX_FAILED_LOGINS;
  }
}
