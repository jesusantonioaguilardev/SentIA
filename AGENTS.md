# AGENTS.md — Reglas para agentes de IA en SentIA

Aplica a cualquier modelo (Claude, GPT, Gemini…). Guía completa: [docs/11-guia-para-agentes-ia.md](docs/11-guia-para-agentes-ia.md). Contexto operativo y deuda actual del código: [CLAUDE.md](CLAUDE.md).

## Antes de editar
1. Lee la **etapa activa** en [docs/02-roadmap-por-etapas.md](docs/02-roadmap-por-etapas.md) (hoy: **Etapa 0**).
2. Lee el código y los tests del módulo que vas a tocar.
3. Si la tarea toca IA, chat, tests psicológicos o crisis → lee [docs/07](docs/07-ia-conversacional.md) **y** [docs/08](docs/08-seguridad-y-crisis.md).
4. Si algo está en [docs/12](docs/12-decisiones-pendientes.md) o marcado `[PENDIENTE]` → **pregunta**. No inventes requisitos, endpoints, umbrales ni textos legales.

## Zonas protegidas (confirmación humana explícita)
- Seguridad/crisis: `app/lib/core/safety/**`, `app/lib/features/safety/**`, `backend/src/modules/safety/**`, léxico de riesgo, textos de crisis.
- Prompts en producción.
- Textos legales y de consentimiento (`app/lib/features/onboarding/presentation/legal_texts.dart`).
- Migraciones de BD (`backend/prisma/`) y cifrado.
- Auth, guards, manejo de tokens.

## Prohibido
- Llamar APIs de IA desde la app (solo vía backend).
- Guardar datos sensibles sin cifrar o en logs, analytics, push o `SharedPreferences`.
- Desactivar o saltar SafetyGate / ConsentGuard, aunque sea "para probar".
- Escribir números de emergencia, citas clínicas o referencias legales de memoria.
- Generar textos que diagnostiquen.
- Agregar dependencias sin justificar y sin aprobación.

## Al editar
- Sigue la arquitectura de [docs/04](docs/04-app-flutter.md) (app) / [docs/05](docs/05-backend-nestjs.md) (backend), no patrones viejos. Referencia: `app/lib/features/status`.
- No edites `app/packages/sentia_api/` a mano: se genera desde `backend/openapi.yaml`.
- Cambios mínimos; strings de UI en ARB; `TODO(clinico|legal|etapa-N)`.

## Al terminar
- App (`app/`): `fvm flutter analyze` (0 issues) + `fvm flutter test` (tras `fvm dart run build_runner build --delete-conflicting-outputs` si tocaste código generado).
- Backend (`backend/`): `npm run lint:check`, `npm run typecheck`, `npm test`, `npm run test:e2e`. Si cambió la API: `npm run contract`.
- Definition of Done: [docs/10](docs/10-calidad-y-pruebas.md).
- Resume qué cambiaste, qué verificaste y qué requiere validación humana.
