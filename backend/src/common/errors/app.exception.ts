import { HttpException, HttpStatus } from '@nestjs/common';

/** Códigos de error que la app interpreta (docs/05 §Convenciones de API). */
export type AppErrorCode =
  | 'VALIDATION_ERROR'
  | 'EMAIL_TAKEN'
  | 'UNDERAGE'
  | 'INVALID_CREDENTIALS'
  | 'ACCOUNT_LOCKED'
  | 'INVALID_TOKEN'
  | 'REFRESH_REUSED'
  | 'CONSENT_REQUIRED'
  | 'DOCUMENT_NOT_CURRENT'
  | 'UNAUTHORIZED';

/** Error de negocio con código estable; el filtro lo serializa sin detalles internos. */
export class AppException extends HttpException {
  constructor(
    readonly code: AppErrorCode,
    message: string,
    status: HttpStatus,
    readonly fields?: string[],
  ) {
    super({ code, message, fields }, status);
  }
}
