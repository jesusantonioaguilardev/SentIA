# AGENTS.md — Reglas para agentes de IA en SentIA

Aplica a cualquier modelo (Claude, GPT, Gemini…). Guía completa: [docs/11-guia-para-agentes-ia.md](docs/11-guia-para-agentes-ia.md). Contexto operativo y deuda actual del código: [CLAUDE.md](CLAUDE.md).

## Antes de editar
1. Lee la **etapa activa** en [docs/02-roadmap-por-etapas.md](docs/02-roadmap-por-etapas.md) (hoy: **Etapa 0**).
2. Lee el código y los tests del módulo que vas a tocar.
3. Si la tarea toca IA, chat, tests psicológicos o crisis → lee [docs/07](docs/07-ia-conversacional.md) **y** [docs/08](docs/08-seguridad-y-crisis.md).
4. Si algo está en [docs/12](docs/12-decisiones-pendientes.md) o marcado `[PENDIENTE]` → **pregunta**. No inventes requisitos, endpoints, umbrales ni textos legales.

## Zonas protegidas (confirmación humana explícita)
- Seguridad/crisis: `features/safety/**`, `modules/safety/**`, `lib/core/utils/risk_signal_detector.dart`, léxico de riesgo, textos de crisis.
- Prompts en producción.
- Textos legales y de consentimiento (`lib/core/constants/legal_texts.dart`).
- Migraciones de BD y cifrado.
- Auth, guards, manejo de tokens.

## Prohibido
- Llamar APIs de IA desde la app (solo vía backend).
- Guardar datos sensibles sin cifrar o en logs, analytics, push o `SharedPreferences`.
- Desactivar o saltar SafetyGate / ConsentGuard, aunque sea "para probar".
- Escribir números de emergencia, citas clínicas o referencias legales de memoria.
- Generar textos que diagnostiquen.
- Agregar dependencias sin justificar y sin aprobación.

## Al editar
- Sigue la arquitectura de [docs/04](docs/04-app-flutter.md) (app) / [docs/05](docs/05-backend-nestjs.md) (backend), no patrones viejos.
- Cambios mínimos; strings de UI en ARB; `TODO(clinico|legal|etapa-N)`.

## Al terminar
- App: `fvm flutter analyze` + `fvm flutter test` (tras `fvm dart run build_runner build --delete-conflicting-outputs` si tocaste código generado).
- Definition of Done: [docs/10](docs/10-calidad-y-pruebas.md).
- Resume qué cambiaste, qué verificaste y qué requiere validación humana.
