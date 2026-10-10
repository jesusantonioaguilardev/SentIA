import { writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { NestFactory } from '@nestjs/core';
import { dump } from 'js-yaml';
import { AppModule } from './app.module';
import { buildOpenApiDocument, configureApp } from './app.setup';

/**
 * Exporta el contrato a `backend/openapi.yaml` (fuente de verdad del cliente Dart, docs/03).
 * No necesita base de datos: Prisma conecta de forma perezosa.
 */
async function main(): Promise<void> {
  process.env.DATABASE_URL ??=
    'postgresql://openapi:openapi@localhost:5432/openapi';
  const app = await NestFactory.create(AppModule, { logger: false });
  configureApp(app);
  const document = buildOpenApiDocument(app);
  const target = resolve(__dirname, '..', 'openapi.yaml');
  writeFileSync(target, dump(document, { noRefs: true, lineWidth: -1 }));
  await app.close();
  console.log(`OpenAPI escrito en ${target}`);
}

void main();
