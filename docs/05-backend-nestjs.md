# 05 · Backend NestJS

Carpeta `backend/` del monorepo ([ADR-0005](adr/0005-monorepo.md)). Monolito modular TypeScript (strict).

## Stack
| Necesidad | Elección |
|---|---|
| Framework | NestJS (Node LTS) |
| ORM | Prisma (migraciones versionadas) |
| BD | PostgreSQL 16+ con `pgvector` (Etapa 5) |
| Validación | `class-validator` / DTOs; config validada al arrancar |
| Auth | Passport JWT (access 15 min, refresh rotativo con detección de reuso), argon2id |
| MFA | TOTP para especialista/admin |
| Tiempo real | `@nestjs/websockets` (Socket.IO o ws) / SSE para streaming de chat |
| Colas [ESC] | BullMQ + Redis |
| Docs API | `@nestjs/swagger` → exporta `openapi.yaml` |
| Logs | pino con redacción de campos sensibles |
| Seguridad HTTP | helmet, CORS restrictivo, rate limit (`@nestjs/throttler`) |

## Estructura
```
src/
  main.ts
  app.module.ts
  common/            # guards (Auth, Roles, Consent, Ownership), interceptors, filters, crypto, pagination
  config/
  modules/
    auth/ users/ consent/ audit/
    chat/            # sesiones y mensajes
    ai/              # AiGateway + providers/{openai,gemini}.provider.ts
    safety/          # SafetyGate, reglas, clasificador, protocolo
    memory/          # resúmenes y contexto
    mood/
    assessments/     # motor de cuestionarios + definiciones JSON
    profile/         # perfil emocional
    voice/           # Etapa 4
    notifications/   # push, correo; historial auditado
    specialists/     # vínculos, notas, metas, umbrales (Etapa 4–5)
    knowledge/       # RAG (Etapa 5)
    admin/           # Etapa 5
prisma/schema.prisma
test/                # e2e
```
Cada módulo: `*.module.ts`, `*.controller.ts`, `*.service.ts`, `dto/`, `*.spec.ts`. Controllers sin lógica de negocio.

## Convenciones de API
- REST, prefijo `/v1`. JSON camelCase. Fechas ISO-8601 UTC.
- Errores: `{ "error": { "code": "CONSENT_REQUIRED", "message": "...", "traceId": "..." } }`.
- Paginación por cursor: `?cursor=&limit=`.
- Idempotencia en POST críticos con header `Idempotency-Key`.
- Versionado: cambios incompatibles → `/v2`.

## Endpoints principales (MVP)
```
POST   /v1/auth/register | login | refresh | logout | password/forgot | password/reset
GET    /v1/me            PATCH /v1/me           DELETE /v1/me   (borrado de cuenta)
GET    /v1/me/export                                            (ARCO: acceso/portabilidad)
GET    /v1/consents/current        POST /v1/consents             (aceptar versión)
GET    /v1/chat/sessions           POST /v1/chat/sessions
GET    /v1/chat/sessions/:id/messages
POST   /v1/chat/sessions/:id/messages        (respuesta en streaming SSE)
POST   /v1/mood/entries            GET /v1/mood/entries?from=&to=
GET    /v1/assessments             POST /v1/assessments/:code/responses
GET    /v1/profile/emotional
GET    /v1/safety/resources                  (recursos de crisis por país)
GET    /v1/health
```

## Autorización
- `RolesGuard` (`user`, `specialist`, `admin`) + `OwnershipGuard` (el recurso pertenece al usuario o a un paciente vinculado con consentimiento vigente).
- `ConsentGuard` en rutas que procesan datos sensibles.
- Acceso de admin a contenido de usuario: requiere motivo y queda en `audit_log`.

## Cifrado
- TLS en tránsito. Cifrado en reposo del disco/BD (proveedor).
- **Cifrado a nivel de campo** (AES-256-GCM, envelope encryption con KMS) para: contenido de mensajes, notas, respuestas de tests, transcripciones, contacto de emergencia.
- Rotación de llaves documentada.

## Borrado de cuenta
Alcance propuesto (qué se borra y qué se conserva seudonimizado): [ADR-0007](adr/0007-borrado-de-cuenta.md).
- `DELETE /v1/me` → marca `deletion_requested_at`, revoca sesiones, job elimina/anonimiza datos en ≤ 30 días [VALIDAR-LEGAL plazo], conserva solo lo legalmente requerido (p. ej. evidencia de consentimiento) y lo documenta.

## Observabilidad
- `traceId` por petición; métricas (latencia, errores, costo IA por usuario); alertas de seguridad.
- Nunca loguear bodies de chat/tests.
