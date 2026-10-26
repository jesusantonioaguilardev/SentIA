import {
  CanActivate,
  ExecutionContext,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';
import { AppException } from '../errors/app.exception';
import { AuthenticatedRequest, IS_PUBLIC } from './auth.decorators';

export interface AccessTokenPayload {
  sub: string;
  sid: string;
  role: string;
  iat: number;
  /** Emisión en milisegundos (ver TokenService). */
  iatMs?: number;
}

/**
 * Guard global: exige access token válido salvo en rutas `@Public()`.
 * Además verifica que la cuenta exista, esté activa y que el token sea
 * posterior a `tokensValidAfter` (logout-all, cambio de contraseña).
 */
@Injectable()
export class JwtAuthGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    private readonly jwt: JwtService,
    private readonly prisma: PrismaService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (isPublic) return true;

    const request = context.switchToHttp().getRequest<AuthenticatedRequest>();
    const header = request.headers.authorization;
    const token = header?.startsWith('Bearer ') ? header.slice(7) : undefined;
    if (!token) throw unauthorized();

    let payload: AccessTokenPayload;
    try {
      payload = await this.jwt.verifyAsync<AccessTokenPayload>(token);
    } catch {
      throw unauthorized();
    }

    const user = await this.prisma.user.findUnique({
      where: { id: payload.sub },
      select: { status: true, tokensValidAfter: true },
    });
    // Un token emitido antes de logout-all o de un cambio de contraseña ya no
    // sirve, aunque no haya expirado. Sin iatMs se toma el inicio del segundo
    // de `iat` (lo más conservador).
    const issuedAt = payload.iatMs ?? payload.iat * 1000;
    if (
      !user ||
      user.status !== 'active' ||
      issuedAt < user.tokensValidAfter.getTime()
    ) {
      throw unauthorized();
    }

    request.user = {
      userId: payload.sub,
      subjectId: payload.sid,
      role: payload.role,
    };
    return true;
  }
}

function unauthorized(): AppException {
  return new AppException(
    'UNAUTHORIZED',
    'Sesión no válida',
    HttpStatus.UNAUTHORIZED,
  );
}
