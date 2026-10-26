import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { MailService } from '../../common/mail/mail.service';
import { PrismaService } from '../../common/prisma/prisma.service';
import { Env } from '../../config/env.schema';
import { AuditService } from '../audit/audit.service';
import { OneTimeTokenService } from '../auth/one-time-token.service';
import { UsersService } from './users.service';

/**
 * Borrado de cuenta sin la app (requisito de Google Play, docs/09 §3):
 * se pide con el correo y se confirma desde un enlace de un solo uso.
 */
@Injectable()
export class AccountDeletionService {
  private readonly baseUrl: string;

  constructor(
    private readonly prisma: PrismaService,
    private readonly oneTime: OneTimeTokenService,
    private readonly users: UsersService,
    private readonly mail: MailService,
    private readonly audit: AuditService,
    config: ConfigService<Env, true>,
  ) {
    this.baseUrl = config.get('PUBLIC_BASE_URL', { infer: true });
  }

  /** Igual que la recuperación: no revela si el correo existe. */
  async request(email: string): Promise<void> {
    const user = await this.prisma.user.findUnique({
      where: { email },
      select: { id: true, subjectId: true },
    });
    if (!user) return;

    const token = await this.oneTime.create(user.id, 'account_deletion');
    const link = `${this.baseUrl}/eliminar-cuenta/confirmar?token=${token}`;
    await this.mail.send({
      to: email,
      subject: 'Confirma la eliminación de tu cuenta de SentIA',
      text: [
        'Recibimos una solicitud para eliminar tu cuenta de SentIA y tus datos.',
        '',
        `Para confirmarla, abre este enlace (vence en 30 minutos): ${link}`,
        '',
        'Si no fuiste tú, ignora este correo: tu cuenta no cambia.',
      ].join('\n'),
    });
    await this.audit.record({
      action: 'user.deletion_requested',
      actorSubjectId: user.subjectId,
      resourceType: 'user',
      reason: 'solicitado desde web',
    });
  }

  async confirm(token: string): Promise<void> {
    const userId = await this.oneTime.consume(token, 'account_deletion');
    const user = await this.prisma.user.findUniqueOrThrow({
      where: { id: userId },
      select: { subjectId: true },
    });
    await this.users.deleteAccount(userId, user.subjectId, 'web');
  }
}
