import { NestFactory } from '@nestjs/core';
import { ConfigService } from '@nestjs/config';
import { SwaggerModule } from '@nestjs/swagger';
import { Logger } from 'nestjs-pino';
import { AppModule } from './app.module';
import { buildOpenApiDocument, configureApp } from './app.setup';
import { Env } from './config/env.schema';

async function bootstrap(): Promise<void> {
  const app = await NestFactory.create(AppModule, { bufferLogs: true });
  app.useLogger(app.get(Logger));
  configureApp(app);

  const config = app.get<ConfigService<Env, true>>(ConfigService);
  // Swagger UI solo fuera de producción; el contrato publicado es openapi.yaml.
  if (config.get('APP_ENV', { infer: true }) !== 'prod') {
    SwaggerModule.setup('docs', app, buildOpenApiDocument(app));
  }

  await app.listen(config.get('PORT', { infer: true }));
}

void bootstrap();
