import { INestApplication } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { DocumentBuilder, OpenAPIObject, SwaggerModule } from '@nestjs/swagger';
import helmet from 'helmet';
import { HttpExceptionFilter } from './common/filters/http-exception.filter';
import { Env } from './config/env.schema';
import { WEB_ROUTES } from './modules/web/web.module';

/** Configuración compartida por `main.ts`, los tests e2e y la exportación de OpenAPI. */
export function configureApp(app: INestApplication): void {
  const config = app.get<ConfigService<Env, true>>(ConfigService);

  // Las páginas web (enlaces de correo, borrado web) quedan fuera de /v1.
  app.setGlobalPrefix('v1', { exclude: WEB_ROUTES });
  app.use(helmet());
  // CORS deny-by-default: solo orígenes listados (portal web, Etapa 4+). La app móvil no usa CORS.
  app.enableCors({ origin: config.get('CORS_ORIGINS', { infer: true }) });
  app.useGlobalFilters(new HttpExceptionFilter());
}

export function buildOpenApiDocument(app: INestApplication): OpenAPIObject {
  const options = new DocumentBuilder()
    .setTitle('SentIA API')
    .setDescription('API del backend de SentIA. Ver docs/05-backend-nestjs.md.')
    .setVersion('1')
    .addBearerAuth()
    .build();
  return SwaggerModule.createDocument(app, options, {
    // `HealthController.check` → `healthCheck`: nombres legibles en el cliente Dart generado.
    operationIdFactory: (controllerKey, methodKey) => {
      const base = controllerKey.replace(/Controller$/, '');
      return `${base[0].toLowerCase()}${base.slice(1)}${methodKey[0].toUpperCase()}${methodKey.slice(1)}`;
    },
  });
}
