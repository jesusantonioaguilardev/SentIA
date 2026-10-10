# SentIA — backend

API NestJS 11 (TypeScript strict) + Prisma 7 + PostgreSQL. Diseño: [docs/05](../docs/05-backend-nestjs.md), datos: [docs/06](../docs/06-base-de-datos.md).

## Desarrollo
```bash
cp .env.example .env     # variables validadas al arrancar (src/config/env.schema.ts)
npm ci                   # también genera el cliente Prisma (postinstall)
npm run db:up            # PostgreSQL + pgvector en Docker
npm run start:dev
```
- `GET /v1/health` → `200 { status: "ok" }` o `503 { status: "degraded" }` si no hay BD.
- Swagger UI en `/docs` (deshabilitado con `APP_ENV=prod`).

## Scripts
| Script | Para qué |
|---|---|
| `npm run lint:check` / `typecheck` | ESLint y `tsc --noEmit` |
| `npm test` / `npm run test:e2e` | Unitarios y e2e (e2e sin BD: `PrismaService` sustituido) |
| `npm run openapi:export` | Escribe `openapi.yaml` (contrato, fuente de verdad) |
| `npm run contract` | `openapi:export` + regenera el cliente Dart en `../app/packages/sentia_api` (requiere Java) |
| `npm run db:up` / `db:down` | Base de datos local |

## Estructura
```
src/
  main.ts · app.module.ts · app.setup.ts (helmet, CORS, /v1, filtro de errores, Swagger)
  config/        validación de entorno con zod
  common/        prisma, filtros (formato { error: { code, message, traceId } })
  modules/       health · auth · users (auth/users vacíos hasta Etapa 1)
prisma/          schema.prisma (sin modelos en Etapa 0; migraciones = zona protegida)
```
