import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Logger,
  Patch,
  Post,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNoContentResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { Throttle } from '@nestjs/throttler';
import type { AuthUser } from '../../common/auth/auth.decorators';
import { CurrentUser, Public } from '../../common/auth/auth.decorators';
import { AccountDeletionService } from './account-deletion.service';
import {
  AccountDeletionRequestDto,
  ConfirmDeletionDto,
  DeleteAccountDto,
  ProfileDto,
  UpdateProfileDto,
} from './dto/users.dto';
import { UsersService } from './users.service';

@ApiTags('me')
@ApiBearerAuth()
@Controller('me')
export class MeController {
  constructor(private readonly users: UsersService) {}

  @Get()
  @ApiOkResponse({ type: ProfileDto })
  get(@CurrentUser() user: AuthUser): Promise<ProfileDto> {
    return this.users.getProfile(user.userId);
  }

  @Patch()
  @ApiOkResponse({ type: ProfileDto })
  update(
    @CurrentUser() user: AuthUser,
    @Body() dto: UpdateProfileDto,
  ): Promise<ProfileDto> {
    return this.users.updateProfile(user.userId, user.subjectId, dto);
  }

  /** Exportación de datos personales (ARCO: acceso y portabilidad). */
  @Get('export')
  @ApiOkResponse({
    description: 'JSON con todos los datos guardados de la persona.',
    schema: { type: 'object', additionalProperties: true },
  })
  export(@CurrentUser() user: AuthUser): Promise<object> {
    return this.users.exportData(user.userId, user.subjectId);
  }

  /** Borra la cuenta de inmediato (ADR-0007). */
  @Throttle({ default: { limit: 10, ttl: 60_000 } })
  @Delete()
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse()
  remove(
    @CurrentUser() user: AuthUser,
    @Body() dto: DeleteAccountDto,
  ): Promise<void> {
    return this.users.deleteWithPassword(
      user.userId,
      user.subjectId,
      dto.password,
    );
  }
}

@ApiTags('account-deletion')
@Controller('account-deletion-requests')
export class AccountDeletionController {
  private readonly logger = new Logger(AccountDeletionController.name);

  constructor(private readonly deletion: AccountDeletionService) {}

  /** Inicia el borrado desde la web: envía un enlace de confirmación. */
  @Public()
  @Throttle({ default: { limit: 5, ttl: 60_000 } })
  @Post()
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse({
    description: 'Misma respuesta exista o no la cuenta.',
  })
  request(@Body() dto: AccountDeletionRequestDto): void {
    this.deletion.request(dto.email).catch((error: unknown) => {
      this.logger.error('Falló la solicitud de borrado', error);
    });
  }

  @Public()
  @Throttle({ default: { limit: 10, ttl: 60_000 } })
  @Post('confirm')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse()
  confirm(@Body() dto: ConfirmDeletionDto): Promise<void> {
    return this.deletion.confirm(dto.token);
  }
}
