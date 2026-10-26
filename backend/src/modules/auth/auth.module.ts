import { Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtModule } from '@nestjs/jwt';
import { Env } from '../../config/env.schema';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { OneTimeTokenService } from './one-time-token.service';
import { PasswordResetService } from './password-reset.service';
import { TokenService } from './token.service';

/** Registro, login, refresh rotativo, cierre de sesión y recuperación (docs/05). */
@Module({
  imports: [
    JwtModule.registerAsync({
      global: true,
      inject: [ConfigService],
      useFactory: (config: ConfigService<Env, true>) => ({
        secret: config.get('JWT_ACCESS_SECRET', { infer: true }),
        signOptions: { algorithm: 'HS256' },
        verifyOptions: { algorithms: ['HS256'] },
      }),
    }),
  ],
  controllers: [AuthController],
  providers: [
    AuthService,
    TokenService,
    OneTimeTokenService,
    PasswordResetService,
  ],
  exports: [TokenService, OneTimeTokenService, PasswordResetService],
})
export class AuthModule {}
