import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as argon2 from 'argon2';
import { HashingService } from '../../common/crypto/hashing.service';
import { MailService } from '../../common/mail/mail.service';
import { PrismaService } from '../../common/prisma/prisma.service';
import { Env } from '../../config/env.schema';
import { AuditService } from '../audit/audit.service';
import { ARGON2_OPTIONS } from './auth.service';
import { OneTimeTokenService } from './one-time-token.service';
import { TokenService } from './token.service';

@Injectable()
export class PasswordResetService {
  private readonly baseUrl: string;

  constructor(
    private readonly prisma: PrismaService,
    private readonly oneTime: OneTimeTokenService,
    private readonly tokens: TokenService,
    private readonly mail: MailService,
    private readonly hashing: HashingService,
    private readonly audit: AuditService,
    config: ConfigService<Env, true>,
  ) {
    this.baseUrl = config.get('PUBLIC_BASE_URL', { infer: true });
  }

  /**
   * Envía el enlace de restablecimiento si la cuenta existe. La respuesta al
   * cliente es la misma en ambos casos para no revelar qué correos existen.
   */
  async request(email: string, ip?: string): Promise<void> {
    const user = await this.prisma.user.findUnique({
      where: { email },
      select: { id: true, subjectId: true, status: true },
    });
    if (!user || user.status !== 'active') return;

    const token = await this.oneTime.create(user.id, 'password_reset');
    const link = `${this.baseUrl}/restablecer-contrasena?token=${token}`;
    await this.mail.send({
      to: email,
      subject: 'Restablece tu contraseña de SentIA',
      text: [
        'Recibimos una solicitud para restablecer tu contraseña.',
        '',
        `Abre este enlace (vence en 30 minutos): ${link}`,
        '',
        'Si no fuiste tú, ignora este correo: tu contraseña no cambia.',
      ].join('\n'),
    });
    await this.audit.record({
      action: 'auth.password_reset_requested',
      actorSubjectId: user.subjectId,
      resourceType: 'user',
      ipHash: this.hashing.hashIp(ip),
    });
  }

  /** Cambia la contraseña y cierra todas las sesiones abiertas. */
  async reset(token: string, password: string, ip?: string): Promise<void> {
    const userId = await this.oneTime.consume(token, 'password_reset');
    const passwordHash = await argon2.hash(password, ARGON2_OPTIONS);
    const user = await this.prisma.user.update({
      where: { id: userId },
      data: { passwordHash, passwordChangedAt: new Date() },
      select: { subjectId: true },
    });
    await this.tokens.revokeAll(userId);
    await this.audit.record({
      action: 'auth.password_reset',
      actorSubjectId: user.subjectId,
      resourceType: 'user',
      ipHash: this.hashing.hashIp(ip),
    });
  }
}
