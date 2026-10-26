import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Logger,
  Post,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiNoContentResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { Throttle } from '@nestjs/throttler';
import type { AuthUser, RequestMeta } from '../../common/auth/auth.decorators';
import {
  CurrentUser,
  Public,
  ReqMeta,
} from '../../common/auth/auth.decorators';
import { AuthService } from './auth.service';
import {
  ForgotPasswordDto,
  LoginDto,
  RefreshDto,
  RegisterDto,
  ResetPasswordDto,
  TokenPairDto,
} from './dto/auth.dto';
import { PasswordResetService } from './password-reset.service';
import { TokenService } from './token.service';

/** Límite más estricto para rutas que aceptan credenciales o envían correos. */
const SENSITIVE_LIMIT = { default: { limit: 10, ttl: 60_000 } };

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  private readonly logger = new Logger(AuthController.name);

  constructor(
    private readonly auth: AuthService,
    private readonly tokens: TokenService,
    private readonly passwordReset: PasswordResetService,
  ) {}

  @Public()
  @Throttle(SENSITIVE_LIMIT)
  @Post('register')
  @ApiCreatedResponse({ type: TokenPairDto })
  register(
    @Body() dto: RegisterDto,
    @ReqMeta() meta: RequestMeta,
  ): Promise<TokenPairDto> {
    return this.auth.register(dto, meta);
  }

  @Public()
  @Throttle(SENSITIVE_LIMIT)
  @Post('login')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: TokenPairDto })
  login(
    @Body() dto: LoginDto,
    @ReqMeta() meta: RequestMeta,
  ): Promise<TokenPairDto> {
    return this.auth.login(dto, meta);
  }

  @Public()
  @Post('refresh')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: TokenPairDto })
  refresh(@Body() dto: RefreshDto): Promise<TokenPairDto> {
    return this.tokens.rotate(dto.refreshToken);
  }

  /** Cierra la sesión de este dispositivo. */
  @Public()
  @Post('logout')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse()
  logout(@Body() dto: RefreshDto): Promise<void> {
    return this.auth.logout(dto.refreshToken);
  }

  /** Cierra la sesión en todos los dispositivos. */
  @ApiBearerAuth()
  @Post('logout-all')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse()
  logoutAll(@CurrentUser() user: AuthUser): Promise<void> {
    return this.auth.logoutAll(user.userId, user.subjectId);
  }

  @Public()
  @Throttle(SENSITIVE_LIMIT)
  @Post('password/forgot')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse({
    description: 'Misma respuesta (y mismo tiempo) exista o no la cuenta.',
  })
  forgotPassword(
    @Body() dto: ForgotPasswordDto,
    @ReqMeta() meta: RequestMeta,
  ): void {
    // Sin await: si se esperara el envío del correo, el tiempo de respuesta
    // revelaría qué cuentas existen.
    this.passwordReset.request(dto.email, meta.ip).catch((error: unknown) => {
      this.logger.error('Falló el envío de restablecimiento', error);
    });
  }

  @Public()
  @Throttle(SENSITIVE_LIMIT)
  @Post('password/reset')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse()
  resetPassword(
    @Body() dto: ResetPasswordDto,
    @ReqMeta() meta: RequestMeta,
  ): Promise<void> {
    return this.passwordReset.reset(dto.token, dto.password, meta.ip);
  }
}
