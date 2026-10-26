import {
  createParamDecorator,
  ExecutionContext,
  SetMetadata,
} from '@nestjs/common';
import type { Request } from 'express';

/** Usuario autenticado que el guard deja en la petición. */
export interface AuthUser {
  userId: string;
  subjectId: string;
  role: string;
}

export interface AuthenticatedRequest extends Request {
  user?: AuthUser;
}

export const IS_PUBLIC = 'isPublic';

/**
 * Marca una ruta como pública. Todo lo demás exige sesión: autorización
 * deny-by-default (docs/03 principio 5).
 */
export const Public = () => SetMetadata(IS_PUBLIC, true);

/** Inyecta el usuario autenticado en el handler. */
export const CurrentUser = createParamDecorator(
  (_: unknown, ctx: ExecutionContext): AuthUser => {
    const user = ctx.switchToHttp().getRequest<AuthenticatedRequest>().user;
    if (!user) throw new Error('CurrentUser usado en una ruta pública');
    return user;
  },
);

/** IP y dispositivo de la petición (para seudonimizar y auditar). */
export interface RequestMeta {
  ip?: string;
  userAgent?: string;
}

export const ReqMeta = createParamDecorator(
  (_: unknown, ctx: ExecutionContext): RequestMeta => {
    const req = ctx.switchToHttp().getRequest<Request>();
    return {
      ip: req.ip,
      userAgent: req.headers['user-agent']?.slice(0, 200),
    };
  },
);
