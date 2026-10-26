import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../common/prisma/prisma.service';

/** Acciones auditables. Agregar aquí en lugar de escribir strings sueltos. */
export type AuditAction =
  | 'auth.register'
  | 'auth.login'
  | 'auth.login_failed'
  | 'auth.refresh_reuse_detected'
  | 'auth.logout'
  | 'auth.logout_all'
  | 'auth.password_reset_requested'
  | 'auth.password_reset'
  | 'user.profile_updated'
  | 'user.data_exported'
  | 'user.deletion_requested'
  | 'user.deleted'
  | 'consent.granted'
  | 'consent.revoked';

export interface AuditEntry {
  action: AuditAction;
  /** Seudónimo del actor; null para eventos anónimos (p. ej. login fallido). */
  actorSubjectId: string | null;
  actorRole?: string;
  resourceType: string;
  resourceId?: string | null;
  reason?: string | null;
  ipHash?: string | null;
}

/**
 * Bitácora append-only (docs/03 principio 6). Solo registra quién, qué y
 * cuándo: nunca contenido, correos ni datos sensibles.
 */
@Injectable()
export class AuditService {
  constructor(private readonly prisma: PrismaService) {}

  async record(entry: AuditEntry): Promise<void> {
    await this.prisma.auditLog.create({
      data: {
        action: entry.action,
        actorSubjectId: entry.actorSubjectId,
        actorRole:
          entry.actorRole ?? (entry.actorSubjectId ? 'user' : 'anonymous'),
        resourceType: entry.resourceType,
        resourceId: entry.resourceId ?? null,
        reason: entry.reason ?? null,
        ipHash: entry.ipHash ?? null,
      },
    });
  }
}
