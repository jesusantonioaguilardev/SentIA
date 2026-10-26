import {
  Body,
  Controller,
  Get,
  Header,
  HttpCode,
  HttpStatus,
  Logger,
  Post,
  Query,
} from '@nestjs/common';
import { ApiExcludeController } from '@nestjs/swagger';
import { Throttle } from '@nestjs/throttler';
import { z } from 'zod';
import { Public } from '../../common/auth/auth.decorators';
import { AppException } from '../../common/errors/app.exception';
import { PasswordResetService } from '../auth/password-reset.service';
import { AccountDeletionService } from '../users/account-deletion.service';
import {
  deletionConfirmForm,
  deletionRequestForm,
  message,
  resetPasswordForm,
} from './pages';

const HTML = 'text/html; charset=utf-8';
const LIMIT = { default: { limit: 10, ttl: 60_000 } };

const resetBody = z.object({
  token: z.string().min(20).max(200),
  password: z.string().min(12).max(128),
  confirm: z.string(),
});
const emailBody = z.object({ email: z.email().max(254) });
const tokenBody = z.object({ token: z.string().min(20).max(200) });

/**
 * Páginas fuera de `/v1` para enlaces de correo y borrado web (Google Play
 * exige un enlace web de borrado de cuenta). No forman parte del contrato.
 */
@ApiExcludeController()
@Public()
@Controller()
export class WebController {
  private readonly logger = new Logger(WebController.name);

  constructor(
    private readonly passwordReset: PasswordResetService,
    private readonly deletion: AccountDeletionService,
  ) {}

  @Get('restablecer-contrasena')
  @Header('Content-Type', HTML)
  resetForm(@Query('token') token?: string): string {
    if (!token)
      return message(
        'Enlace incompleto',
        'Abre el enlace completo que te enviamos por correo.',
      );
    return resetPasswordForm(token);
  }

  @Throttle(LIMIT)
  @Post('restablecer-contrasena')
  @HttpCode(HttpStatus.OK)
  @Header('Content-Type', HTML)
  async reset(@Body() body: unknown): Promise<string> {
    const parsed = resetBody.safeParse(body);
    if (!parsed.success) {
      const token = tokenBody.safeParse(body);
      return token.success
        ? resetPasswordForm(
            token.data.token,
            'La contraseña debe tener entre 12 y 128 caracteres.',
          )
        : message('Enlace no válido', 'Pide un nuevo enlace desde la app.');
    }
    if (parsed.data.password !== parsed.data.confirm) {
      return resetPasswordForm(
        parsed.data.token,
        'Las contraseñas no coinciden.',
      );
    }
    try {
      await this.passwordReset.reset(parsed.data.token, parsed.data.password);
    } catch (error) {
      if (error instanceof AppException) {
        return message(
          'Enlace no válido',
          'El enlace no es válido o ya expiró. Pide uno nuevo desde la app.',
        );
      }
      throw error;
    }
    return message(
      'Contraseña actualizada',
      'Ya puedes iniciar sesión en la app con tu nueva contraseña.',
    );
  }

  @Get('eliminar-cuenta')
  @Header('Content-Type', HTML)
  deletionForm(): string {
    return deletionRequestForm();
  }

  @Throttle({ default: { limit: 5, ttl: 60_000 } })
  @Post('eliminar-cuenta')
  @HttpCode(HttpStatus.OK)
  @Header('Content-Type', HTML)
  requestDeletion(@Body() body: unknown): string {
    const parsed = emailBody.safeParse(body);
    if (parsed.success) {
      this.deletion
        .request(parsed.data.email.trim().toLowerCase())
        .catch((error: unknown) =>
          this.logger.error('Falló la solicitud de borrado', error),
        );
    }
    // Misma respuesta exista o no la cuenta.
    return message(
      'Revisa tu correo',
      'Si existe una cuenta con ese correo, te enviamos un enlace para confirmar la eliminación. Vence en 30 minutos.',
    );
  }

  @Get('eliminar-cuenta/confirmar')
  @Header('Content-Type', HTML)
  confirmForm(@Query('token') token?: string): string {
    if (!token)
      return message(
        'Enlace incompleto',
        'Abre el enlace completo que te enviamos por correo.',
      );
    return deletionConfirmForm(token);
  }

  @Throttle(LIMIT)
  @Post('eliminar-cuenta/confirmar')
  @HttpCode(HttpStatus.OK)
  @Header('Content-Type', HTML)
  async confirmDeletion(@Body() body: unknown): Promise<string> {
    const parsed = tokenBody.safeParse(body);
    if (!parsed.success)
      return message('Enlace no válido', 'Solicita uno nuevo.');
    try {
      await this.deletion.confirm(parsed.data.token);
    } catch (error) {
      if (error instanceof AppException) {
        return message(
          'Enlace no válido',
          'El enlace no es válido o ya expiró. Solicita uno nuevo.',
        );
      }
      throw error;
    }
    return message(
      'Cuenta eliminada',
      'Tu cuenta y tus datos se eliminaron. Gracias por haber usado SentIA.',
    );
  }
}
