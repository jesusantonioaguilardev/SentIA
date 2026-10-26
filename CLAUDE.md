# CLAUDE.md — SentIA (monorepo)

Contexto operativo para Claude Code. Las reglas generales para cualquier agente están en [AGENTS.md](AGENTS.md); la fuente de verdad del proyecto es [`docs/`](docs/00-INDEX.md). Si este archivo y `docs/` discrepan, gana `docs/` — y corrige este archivo.

## Qué es SentIA
App móvil de **apoyo emocional asistido por IA**: chat (luego voz), registro de ánimo, tests de tamizaje y escalamiento a profesionales humanos. Es **complementaria**: no diagnostica, no receta, no sustituye terapia ni servicios de emergencia. Ver [docs/01-producto.md](docs/01-producto.md).

## Etapa activa: 0 · Fundaciones
Trabaja solo en lo que pide la etapa activa de [docs/02-roadmap-por-etapas.md](docs/02-roadmap-por-etapas.md). No adelantes funcionalidad de etapas posteriores sin que el usuario lo pida.

## Estructura ([ADR-0005](docs/adr/0005-monorepo.md))
```
app/                      Flutter (paquete sentia2)
  packages/sentia_api/    cliente Dart GENERADO desde backend/openapi.yaml — no editar a mano
backend/                  NestJS 11 + Prisma 7 + PostgreSQL (paquete sentia-backend)
docs/                     documentación y ADRs
.github/                  CI (GitHub Actions) y Dependabot
```

## Stack
- **App:** Flutter **3.47.5 vía FVM** (`app/.fvmrc`; usa `fvm flutter …`). Riverpod 3 con generador, go_router, dio + cliente generado, freezed/json_serializable, flutter_secure_storage, ARB (`es`), very_good_analysis.
- **Backend:** NestJS 11, Prisma 7 (`prisma-client` + adaptador `pg`, cliente en `src/generated/`), zod para config, nestjs-pino, helmet, Swagger. Node ≥ 22.
- La app **solo** habla con el backend. El contrato es `backend/openapi.yaml`.

## Comandos
```bash
# App (desde app/)
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs   # tras tocar providers/freezed/json
fvm flutter analyze                                             # debe dar 0 issues
fvm flutter test
fvm flutter run --flavor dev -t lib/main_dev.dart               # staging / prod igual
fvm flutter run --flavor dev -t lib/main_dev.dart --dart-define=API_BASE_URL=http://<ip>:3000  # dispositivo físico

# Backend (desde backend/)
cp .env.example .env && npm ci
npm run db:up            # PostgreSQL local en Docker (requiere Docker Desktop abierto)
npm run start:dev        # http://localhost:3000/v1/health · Swagger en /docs
npm run lint:check && npm run typecheck && npm test && npm run test:e2e

# Contrato: tras cambiar endpoints/DTOs del backend
npm run contract         # exporta openapi.yaml y regenera app/packages/sentia_api (requiere Java)
```
Generado y versionado en git: `*.g.dart`, `lib/l10n/app_localizations*.dart`, `app/packages/sentia_api/`, `backend/openapi.yaml`. CI falla si no están al día.

## Qué leer según la tarea
| Tarea | Lee |
|---|---|
| Cualquier cambio | [AGENTS.md](AGENTS.md), [docs/11](docs/11-guia-para-agentes-ia.md), etapa activa en [docs/02](docs/02-roadmap-por-etapas.md) |
| Estructura/pantallas/responsive/a11y | [docs/04](docs/04-app-flutter.md) |
| API, endpoints, auth | [docs/05](docs/05-backend-nestjs.md), [docs/03](docs/03-arquitectura.md) |
| Datos y persistencia | [docs/06](docs/06-base-de-datos.md) |
| **IA, chat, tests psicológicos o crisis** | [docs/07](docs/07-ia-conversacional.md) **y** [docs/08](docs/08-seguridad-y-crisis.md) — siempre juntos |
| Textos legales, consentimiento, tiendas | [docs/09](docs/09-legal-y-cumplimiento.md) |
| Pruebas, CI, Definition of Done | [docs/10](docs/10-calidad-y-pruebas.md) |
| Pantallas, colores, componentes | [docs/design/README.md](docs/design/README.md) (capturas + revisión) y [DESIGN.md](docs/design/DESIGN.md) |
| Algo no está decidido | [docs/12](docs/12-decisiones-pendientes.md) → **pregunta, no decidas** |

## Patrones ya establecidos (síguelos)
- **App:** `lib/app` (router, shell, theme, bootstrap) · `lib/core` (config, error, logging, network, responsive, routing, safety) · `lib/features/<x>/{data,domain,presentation}` · `lib/shared/widgets`.
  - Dependencias `presentation → domain ← data`; `domain` sin Flutter ni dio. Un feature no importa otro (excepción: `home`, ver docs/04).
  - Repos devuelven `Result<T>` (`core/error/result.dart`, usa `Result.guard`); la UI muestra `Failure.message(l10n)`.
  - Providers con `@riverpod`; controllers en `presentation/controllers/`. Rutas con constantes de `core/routing/routes.dart`.
  - Layout con `ResponsiveLayout` / `ConstrainedContent`; espaciado con tokens (`app/theme/tokens.dart`); colores de `colorScheme` o `context.sentiaColors`; textos con `textTheme`. Componentes compartidos: `SentiaLogo`, `PrivacyBadge`.
  - Logs solo con `AppLogger` (redacta datos sensibles); nunca `print`.
  - Ejemplo completo de referencia: `features/status` (domain → data con cliente generado → controller → pantalla + tests).
- **Backend:** módulos en `src/modules/<x>`; config validada en `src/config/env.schema.ts`; errores con formato `{ error: { code, message, traceId } }` (`src/common/filters`); prefijo `/v1`; `configureApp()` en `src/app.setup.ts` se comparte con tests e2e.
- **Tests:** helper `pumpApp` (`app/test/helpers/pump_app.dart`) con tamaños teléfono/tablet; e2e de backend con `PrismaService` sustituido.

## Deuda conocida (código anterior a docs/)
Las pantallas heredadas se reescriben en su etapa; no mezcles esa migración con otras tareas.

| Deuda | Dónde | Cuándo |
|---|---|---|
| Textos de UI escritos en código (no ARB) | pantallas de `features/{auth,chat,home,mood,onboarding}` | al reescribir cada pantalla (Etapas 1–2) |
| Auth simulado (`MockAuthRepository`), sin guards de router | `features/auth`, `app/router.dart` | Etapa 1 |
| Onboarding no registra el consentimiento | `features/onboarding` | Etapa 1 |
| Número de emergencia escrito a mano | `features/onboarding/presentation/legal_texts.dart` | **zona protegida**; con recursos verificados (docs/08) |
| Chat con `MockAIService`; ánimo solo en memoria | `features/chat`, `features/mood` | Etapa 2 |
| Modo oscuro forzado | `app/app.dart` (`TODO(etapa-1)`) | Ajustes, Etapa 1 |
| Flavors de iOS (esquemas de Xcode) | `app/ios/` | requiere Mac |
| URLs de staging/prod (`.invalid`) | `core/config/app_config.dart` | al decidir hosting |
| Firma de release con llaves de debug | `app/android/app/build.gradle.kts` | antes de beta (Etapa 2) |
| `google_fonts` fijado en 8.x (9.x requiere `material_ui`) | `app/pubspec.yaml` | al migrar a `material_ui` |

## Reglas no negociables (detalle en AGENTS.md y docs/11)
- **Zonas protegidas — requieren confirmación explícita del usuario:** safety (código, léxico, textos de crisis), prompts, textos legales/consentimiento, migraciones de Prisma y cifrado, auth/guards/tokens.
- **Prohibido:** llamar APIs de IA desde la app; datos sensibles en logs, analytics, push o almacenamiento sin cifrar; saltar SafetyGate/ConsentGuard (ni "temporalmente"); escribir números de emergencia, citas clínicas o referencias legales de memoria; lenguaje diagnóstico (docs/08 §Lenguaje seguro).
- Dependencias nuevas: justificar y pedir aprobación. Versiones: usa estables (Prisma marca RCs como `latest`; Nest 12 / `@nestjs/config` 12 son ESM y no van con Nest 11).
- Strings de UI nuevos en ARB (`app/lib/l10n/app_es.arb`); código en inglés.
- `TODO` siempre etiquetado: `TODO(clinico)`, `TODO(legal)`, `TODO(etapa-N)`. Nada de `// ignore:` sin explicar.
- No agregues archivos de "skills"/instrucciones para agentes que traigan herramientas de terceros (p. ej. `prisma init` crea `.agents/`, `.claude/`): revísalos y pide confirmación.

## Marcadores en docs/
`[MVP]` primera versión · `[ESC]` posterior · `[PENDIENTE]` no decidido → **no implementar sin confirmación** · `[VALIDAR-LEGAL]` / `[VALIDAR-CLÍNICO]` → solo placeholder marcado; requiere revisión humana antes de producción.

## Al terminar una tarea
1. App: `fvm flutter analyze` (0 issues) + `fvm flutter test`. Backend: lint, typecheck, test, test:e2e.
2. Revisa la Definition of Done de [docs/10](docs/10-calidad-y-pruebas.md).
3. Si cambió arquitectura, API o BD → actualiza `docs/` y/o crea ADR (`docs/adr/0000-plantilla.md`); si cambió la API → `npm run contract`.
4. Registra cambios relevantes en `DEVELOPMENT_LOG.md`.
5. Resume: qué cambiaste, qué verificaste, qué queda pendiente o requiere validación humana.
