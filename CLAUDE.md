# CLAUDE.md — SentIA (app Flutter)

Contexto operativo para Claude Code. Las reglas generales para cualquier agente están en [AGENTS.md](AGENTS.md); la fuente de verdad del proyecto es [`docs/`](docs/00-INDEX.md). Si este archivo y `docs/` discrepan, gana `docs/` — y corrige este archivo.

## Qué es SentIA
App móvil de **apoyo emocional asistido por IA**: chat (luego voz), registro de ánimo, tests de tamizaje y escalamiento a profesionales humanos. Es **complementaria**: no diagnostica, no receta, no sustituye terapia ni servicios de emergencia. Ver [docs/01-producto.md](docs/01-producto.md).

## Etapa activa: 0 · Fundaciones
Trabaja solo en lo que pide la etapa activa de [docs/02-roadmap-por-etapas.md](docs/02-roadmap-por-etapas.md). No adelantes funcionalidad de etapas posteriores sin que el usuario lo pida.

## Stack
- **App:** Flutter **3.35.0 vía FVM** (`.fvmrc`) — usa `fvm flutter …` / `fvm dart …`.
- Estado/DI: Riverpod con generador (`riverpod_annotation`, `*.g.dart`). Modelos: `freezed` + `json_serializable`. Red: `dio`. Tokens: `flutter_secure_storage`.
- Objetivo de Etapa 0 (aún no instalado): `go_router`, `flutter_localizations` + ARB, lints estrictos, flavors `dev/staging/prod`.
- **Backend:** NestJS + Prisma + PostgreSQL en repo separado `sentia-backend` (**aún no existe**; monorepo vs 2 repos está en [docs/12](docs/12-decisiones-pendientes.md)). La app solo habla con ese backend; contrato en `openapi.yaml`.

## Comandos
```bash
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs   # obligatorio tras tocar providers/freezed/json
fvm flutter analyze
fvm flutter test
fvm flutter run            # con flavors (cuando existan): --flavor dev -t lib/main_dev.dart
```
Si todo sale en rojo: `fvm flutter clean` → `pub get` → `build_runner` (ver `DEVELOPMENT_LOG.md`).

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
| Algo no está decidido | [docs/12](docs/12-decisiones-pendientes.md) → **pregunta, no decidas** |

## Arquitectura objetivo (resumen de docs/04)
```
lib/app/        router, theme/tokens, flavors
lib/core/       network, error (Result/Failure), responsive, a11y, security, logging
lib/features/<x>/{data,domain,presentation}
lib/shared/widgets/   design system (SButton, SCrisisButton, …)
lib/l10n/app_es.arb
```
- Dependencias: `presentation → domain ← data`. `domain` es Dart puro (sin Flutter ni `dio`).
- Un feature **no** importa otro; lo compartido sube a `core/` o `shared/`.
- Controllers `AsyncNotifier`; repos devuelven `Result<T, Failure>`; layouts vía `ResponsiveLayout` (compact < 600, medium 600–839, expanded ≥ 840 dp), nunca tamaños fijos.

## Estado actual del código (deuda conocida)
El código es anterior a `docs/`. **Código nuevo sigue docs/04, no el patrón viejo.** Migra por partes, en la tarea de Etapa 0 correspondiente, sin mezclar migraciones con otras tareas.

| Deuda | Dónde | Objetivo |
|---|---|---|
| Capas globales, no feature-first | `lib/data/`, `lib/domain/` | Mover a `lib/features/<x>/{data,domain}` |
| Navegación con `MaterialApp.routes` | `lib/app.dart` | `go_router` en `lib/app/router.dart` con guards |
| Modo oscuro forzado (temporal) | `lib/app.dart` (`TODO(etapa-1)`) | Preferencia en Ajustes (Etapa 1) |
| Ánimo guardado en `SharedPreferences` (dato sensible) | `lib/data/datasources/local/mood_local_data_source.dart` | Backend (Etapa 2); local solo cifrado |
| Provider `sharedPreferences` duplicado | `lib/core/providers/storage_providers.dart`, `lib/data/providers/repository_providers.dart` | Uno solo en `core/` |
| Número de emergencia escrito a mano | `lib/core/constants/legal_texts.dart` | Recursos verificados (`safety_resources`) — **zona protegida, pedir confirmación** |
| Textos de UI en código | pantallas en `lib/features/**` | ARB (`AppLocalizations`) |
| `Failure` sin `Result`, sin logger con redacción | `lib/core/errors/failures.dart` | `lib/core/error/` + `lib/core/logging/` |
| Sin flavors; `applicationId = com.example.sentia2` | `android/app/build.gradle.kts`, `ios/` | Flavors dev/staging/prod (bundle id [PENDIENTE]) |
| Lints por defecto | `analysis_options.yaml` | Estricto |
| Carpeta sin uso | `android_old/` | Eliminar tras confirmar |
| No es repositorio git | raíz | `git init` antes de reorganizar |

Correcto y a conservar:
- `MockAIService` (`lib/data/services/ai_service_impl.dart`) no llama a APIs de IA — así debe seguir; la IA real va por backend.
- `lib/core/utils/risk_signal_detector.dart` es la red de seguridad local/offline que pide docs/08. **Zona protegida**: no la borres ni la debilites; al migrar, muévela a `features/safety/`.

## Reglas no negociables (detalle en AGENTS.md y docs/11)
- **Zonas protegidas — requieren confirmación explícita del usuario:** safety (código, léxico, textos de crisis), prompts, textos legales/consentimiento, migraciones y cifrado, auth/guards/tokens.
- **Prohibido:** llamar APIs de IA desde la app; datos sensibles en logs, analytics, push o `SharedPreferences`; saltar SafetyGate/ConsentGuard (ni "temporalmente"); escribir números de emergencia, citas clínicas o referencias legales de memoria; lenguaje diagnóstico (ver tabla en docs/08 §Lenguaje seguro).
- Dependencias nuevas: justificar y pedir aprobación.
- Strings de UI en ARB (español MX); código e identificadores en inglés.
- `TODO` siempre etiquetado: `TODO(clinico)`, `TODO(legal)`, `TODO(etapa-N)`. Nada de `// ignore:` sin explicar.
- Cambios mínimos y localizados; no reformatees archivos ajenos.

## Marcadores en docs/
`[MVP]` primera versión · `[ESC]` posterior · `[PENDIENTE]` no decidido → **no implementar sin confirmación** · `[VALIDAR-LEGAL]` / `[VALIDAR-CLÍNICO]` → implementar solo como placeholder marcado; requiere revisión humana antes de producción.

## Al terminar una tarea
1. `fvm flutter analyze` (0 issues) y `fvm flutter test`.
2. Revisa la Definition of Done de [docs/10](docs/10-calidad-y-pruebas.md).
3. Si cambió arquitectura, API o BD → actualiza `docs/` y/o crea ADR (`docs/adr/0000-plantilla.md`).
4. Registra cambios relevantes en `DEVELOPMENT_LOG.md`.
5. Resume: qué cambiaste, qué verificaste, qué queda pendiente o requiere validación humana.
