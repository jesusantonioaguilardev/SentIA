import { Injectable, Logger, OnModuleDestroy } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createTransport, Transporter } from 'nodemailer';
import { Env } from '../../config/env.schema';

export interface MailMessage {
  to: string;
  subject: string;
  text: string;
}

/**
 * Envío de correo transaccional. En desarrollo va a Mailpit (docker-compose);
 * el proveedor de producción está [PENDIENTE] (docs/12).
 * Los correos nunca incluyen datos sensibles: solo enlaces de un solo uso.
 */
@Injectable()
export class MailService implements OnModuleDestroy {
  private readonly logger = new Logger(MailService.name);
  private readonly transporter: Transporter;
  private readonly from: string;

  constructor(config: ConfigService<Env, true>) {
    this.transporter = createTransport(config.get('SMTP_URL', { infer: true }));
    this.from = config.get('MAIL_FROM', { infer: true });
  }

  async send(message: MailMessage): Promise<void> {
    await this.transporter.sendMail({ from: this.from, ...message });
    // No se registra el destinatario: es un dato personal.
    this.logger.log(`Correo enviado: ${message.subject}`);
  }

  onModuleDestroy(): void {
    this.transporter.close();
  }
}
