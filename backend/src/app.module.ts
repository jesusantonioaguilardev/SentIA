import { randomUUID } from 'node:crypto';
import { Module } from '@nestjs/common';
import { APP_GUARD, APP_PIPE } from '@nestjs/core';
import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';
import { JwtAuthGuard } from './common/auth/jwt-auth.guard';
import { ZodValidationPipe } from './common/validation/zod-validation.pipe';
import { ConsentModule } from './modules/consent/consent.module';
import { SafetyModule } from './modules/safety/safety.module';
import { WebModule } from './modules/web/web.module';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { LoggerModule } from 'nestjs-pino';
import { CryptoModule } from './common/crypto/crypto.module';
import { MailModule } from './common/mail/mail.module';
import { PrismaModule } from './common/prisma/prisma.module';
import { AuditModule } from './modules/audit/audit.module';
import { Env, validateEnv } from './config/env.schema';
import { AuthModule } from './modules/auth/auth.module';
import { HealthModule } from './modules/health/health.module';
import { UsersModule } from './modules/users/users.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true, validate: validateEnv }),
    LoggerModule.forRootAsync({
      inject: [ConfigService],
      useFactory: (config: ConfigService<Env, true>) => ({
        pinoHttp: {
          level: config.get('LOG_LEVEL', { infer: true }),
          // traceId por petición; se devuelve en los errores (docs/05).
          genReqId: (req) => {
            const incoming = req.headers['x-request-id'];
            return typeof incoming === 'string' ? incoming : randomUUID();
          },
          // Nunca loguear credenciales; los bodies no se loguean (pino-http no lo hace por defecto).
          redact: {
            paths: [
              'req.headers.authorization',
              'req.headers.cookie',
              'res.headers["set-cookie"]',
            ],
            censor: '[REDACTED]',
          },
          transport:
            config.get('NODE_ENV', { infer: true }) === 'development'
              ? { target: 'pino-pretty', options: { singleLine: true } }
              : undefined,
        },
      }),
    }),
    // Límite general por IP; las rutas sensibles lo endurecen con @Throttle.
    // En tests se desactiva para no volver frágiles los e2e.
    ThrottlerModule.forRoot({
      throttlers: [{ ttl: 60_000, limit: 120 }],
      skipIf: () => process.env.NODE_ENV === 'test',
    }),
    PrismaModule,
    CryptoModule,
    MailModule,
    AuditModule,
    HealthModule,
    AuthModule,
    UsersModule,
    ConsentModule,
    SafetyModule,
    WebModule,
  ],
  providers: [
    { provide: APP_GUARD, useClass: ThrottlerGuard },
    // Deny-by-default: toda ruta exige sesión salvo @Public() (docs/03).
    { provide: APP_GUARD, useClass: JwtAuthGuard },
    { provide: APP_PIPE, useClass: ZodValidationPipe },
  ],
})
export class AppModule {}
