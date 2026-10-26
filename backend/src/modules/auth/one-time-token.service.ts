import { HttpStatus, Injectable } from '@nestjs/common';
import { AppException } from '../../common/errors/app.exception';
import { HashingService } from '../../common/crypto/hashing.service';
import { PrismaService } from '../../common/prisma/prisma.service';
import { OneTimeTokenPurpose } from '../../generated/prisma/client';

/** Vigencia de los enlaces enviados por correo. */
export const ONE_TIME_TOKEN_TTL_MS = 30 * 60 * 1000;

/**
 * Tokens de un solo uso para enlaces por correo (restablecer contraseña,
 * confirmar borrado). En BD solo se guarda su hash.
 */
@Injectable()
export class OneTimeTokenService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly hashing: HashingService,
  ) {}

  /** Crea un token nuevo e invalida los anteriores del mismo propósito. */
  async create(userId: string, purpose: OneTimeTokenPurpose): Promise<string> {
    const token = this.hashing.newToken();
    await this.prisma.$transaction([
      this.prisma.oneTimeToken.updateMany({
        where: { userId, purpose, usedAt: null },
        data: { usedAt: new Date() },
      }),
      this.prisma.oneTimeToken.create({
        data: {
          userId,
          purpose,
          tokenHash: this.hashing.hashToken(token),
          expiresAt: new Date(Date.now() + ONE_TIME_TOKEN_TTL_MS),
        },
      }),
    ]);
    return token;
  }

  /** Marca el token como usado y devuelve su usuario; lanza si no es válido. */
  async consume(token: string, purpose: OneTimeTokenPurpose): Promise<string> {
    const stored = await this.prisma.oneTimeToken.findUnique({
      where: { tokenHash: this.hashing.hashToken(token) },
    });
    if (
      !stored ||
      stored.purpose !== purpose ||
      stored.expiresAt.getTime() <= Date.now()
    ) {
      throw invalid();
    }
    const { count } = await this.prisma.oneTimeToken.updateMany({
      where: { id: stored.id, usedAt: null },
      data: { usedAt: new Date() },
    });
    if (count === 0) throw invalid();
    return stored.userId;
  }
}

function invalid(): AppException {
  return new AppException(
    'INVALID_TOKEN',
    'El enlace no es válido o ya expiró',
    HttpStatus.BAD_REQUEST,
  );
}
