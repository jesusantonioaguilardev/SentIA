import {
  CanActivate,
  ExecutionContext,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { AuthenticatedRequest } from '../../common/auth/auth.decorators';
import { AppException } from '../../common/errors/app.exception';
import { ConsentService } from './consent.service';

/**
 * Exige consentimiento vigente de todos los documentos obligatorios antes de
 * procesar datos sensibles (docs/05 §Autorización). Se aplica con
 * `@UseGuards(ConsentGuard)` en chat, ánimo y tests (Etapa 2+).
 * No puede desactivarse por configuración (docs/11).
 */
@Injectable()
export class ConsentGuard implements CanActivate {
  constructor(private readonly consents: ConsentService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const user = context.switchToHttp().getRequest<AuthenticatedRequest>().user;
    if (!user || !(await this.consents.hasRequiredConsents(user.subjectId))) {
      throw new AppException(
        'CONSENT_REQUIRED',
        'Falta tu consentimiento vigente para continuar',
        HttpStatus.FORBIDDEN,
      );
    }
    return true;
  }
}
