import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import type { Request, Response } from 'express';

/**
 * Formato de error único de la API (docs/05):
 * `{ "error": { "code", "message", "traceId" } }`.
 * Nunca devuelve stack traces ni detalles internos al cliente.
 */
@Catch()
export class HttpExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(HttpExceptionFilter.name);

  catch(exception: unknown, host: ArgumentsHost): void {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request & { id?: string }>();

    const status =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    if (status >= 500) {
      this.logger.error(exception);
    }

    const code = (HttpStatus[status] as string | undefined) ?? 'ERROR';

    response.status(status).json({
      error: {
        code,
        message:
          exception instanceof HttpException && status < 500
            ? exception.message
            : 'Error interno',
        traceId: request.id ?? null,
      },
    });
  }
}
