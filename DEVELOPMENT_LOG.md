# Bitácora de Desarrollo - SentIA2

Este documento registra los cambios, decisiones arquitectónicas y comandos utilizados en el proyecto para mantener un control total y facilitar el aprendizaje.

## 2026-10-10 - Etapa 0: fundaciones

### Decisiones
- **Monorepo** `app/` + `backend/` (ADR-0005). **Bundle id** `com.sentia.app` (+ `.dev`, `.staging`).
- **Flutter 3.47.5** (antes 3.35.0). Riverpod 3, freezed 4, go_router 18, very_good_analysis 11, logger.
- Cliente de API generado con **openapi-generator (dart-dio)** en `app/packages/sentia_api`.
- Textos heredados pasan a ARB al reescribir cada pantalla; el código nuevo ya usa ARB.

### Backend (`backend/`)
NestJS 11, config validada con zod, helmet, CORS cerrado, prefijo `/v1`, pino con `traceId` y redacción, formato de error común, Prisma 7 (sin modelos), `GET /v1/health`, Swagger en `/docs`, `openapi.yaml`, docker-compose con pgvector. 4 tests unitarios + 3 e2e.

### App (`app/`)
- Reorganizada a feature-first (`app/`, `core/`, `features/`, `shared/`, `l10n/`). Código muerto eliminado (capa de datos de ánimo sobre `SharedPreferences`, que nunca se conectó; modelos y repos de chat sin uso).
- Flavors Android dev/staging/prod (`main_<flavor>.dart`), HTTP en claro solo en dev hacia 10.0.2.2.
- `Result`/`Failure`, `AppLogger` con redacción, `ResponsiveLayout` + breakpoints, tokens de diseño, shell adaptativo (bottom nav / rail), ARB.
- Feature `status` ("Hola, soy SentIA") que llama a `/v1/health` con el cliente generado.
- `MoodScreen` (existía sin ruta) conectada a la pestaña Historial.
- Corregido: `RoundedBottomNav` con altura fija se desbordaba con texto grande.
- 26 tests; `flutter analyze` sin issues.

### Problemas encontrados
- `prisma@latest` apunta a una RC (8.0.0-rc) → se fijó 7.10.0. `@nestjs/config` 12 es solo ESM → 4.x.
- `prisma init` instaló "skills" de agentes de terceros (`.agents/`, `.claude/`, `.windsurf/`) → eliminadas sin usar.
- `google_fonts` 9 requiere `material_ui` → fijado 8.2.1.
- Flutter 3.47 exige Gradle ≥ 8.14 → Gradle 9.3.1, AGP 9.1.0, Kotlin 2.4.0 (versiones del template), `resValues` habilitado.

### Pendiente para cerrar Etapa 0
- Subir a GitHub y ver CI en verde. Flavors de iOS (requiere Mac). Probar `/v1/health` con BD real (Docker Desktop).

---

## 2026-10-10 - Documentación para agentes y revisión de docs/

### Tareas Realizadas:
1. **Revisión de `docs/`** (00–12 + ADRs) contra el código actual. El código es anterior a los docs; la deuda quedó inventariada en `CLAUDE.md`.
2. **Creados `CLAUDE.md` y `AGENTS.md`** en la raíz (entregable transversal de Etapa 0).
3. **Docs actualizados:** `12` (nuevas decisiones pendientes: modelo de negocio y borrado vs auditoría como bloqueantes de Etapa 1, monorepo, bundle id, feature flags, set de evaluación de crisis, edad autodeclarada); `08` (recursos de crisis empaquetados para offline; separación tuning/holdout); `03` (streaming fuera del codegen; cifrado en reposo vs envío al LLM); `02` (tareas de migración y git); `00` (enlaces a AGENTS/CLAUDE).
4. **Modo oscuro forzado temporalmente** en `lib/app.dart` (`TODO(etapa-1)`: preferencia en Ajustes).

---

## [Fecha Actual] - Resolución de Errores de Sincronización y Compilación

### Tareas Realizadas:
1. **Saneamiento de Entorno:** Se identificó un conflicto en la caché (`Invalid depfile`) y falta de archivos generados. Se estableció el flujo de limpieza profunda.
2. **Corrección de app_theme.dart:** Se cambió `CardTheme` por `CardThemeData` (clase de configuración correcta) eliminando el error de asignación de tipos en el constructor del tema.
3. **Compatibilidad de Colores:** Se migró temporalmente de `.withValues()` a `.withOpacity()` para asegurar compatibilidad con versiones del SDK de Flutter inferiores a la 3.24 si fuera el caso del usuario.
4. **Validación de Dependencias:** Se confirmó que `intl` está presente para el correcto funcionamiento del historial emocional.

### Comandos de "Rescate" (Si ves todo en rojo):
1. `flutter clean`: Borra la basura técnica de compilaciones fallidas.
2. `flutter pub get`: Descarga las librerías necesarias.
3. `dart run build_runner build --delete-conflicting-outputs`: **INDISPENSABLE**. Genera los archivos `.g.dart` de Riverpod. Sin esto, los providers no existen para Flutter.

---

## [Fecha Anterior] - Implementación de Arquitectura Legal y Flujo de Onboarding
... (Historial conservado) ...
