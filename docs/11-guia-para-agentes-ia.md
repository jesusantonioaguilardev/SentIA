# 11 · Guía para agentes de IA que editan código

Objetivo: que cualquier modelo (Claude, GPT, Gemini…) pueda entender, modificar y extender SentIA **sin romper seguridad, legalidad ni arquitectura**.

## Antes de editar
1. Lee `AGENTS.md` y la etapa activa en `02-roadmap-por-etapas.md`.
2. Identifica el módulo (`features/<x>` o `modules/<x>`) y lee su código + tests antes de cambiar.
3. Si la tarea toca IA, chat, tests o crisis → lee `07` y `08`.
4. Si falta información → pregunta. No inventes requisitos, endpoints, umbrales ni textos legales.

## Al editar
- **Sigue el patrón existente** del módulo; no introduzcas otro estilo (otro state manager, otra librería HTTP, etc.).
- Dependencias nuevas: justifica (mantenida, licencia compatible, sin trackers) y pide aprobación.
- Cambios mínimos y localizados; no reformatees archivos ajenos a la tarea.
- Nada de `// ignore:` para silenciar analyzer sin explicar por qué.
- No dejes código muerto, prints ni `TODO` sin etiqueta (`TODO(clinico)`, `TODO(legal)`, `TODO(etapa-N)`).
- Nombres descriptivos en inglés para código; textos de UI en ARB (español).
- Comenta el **porqué**, no el qué. Documenta con `///` APIs públicas de `domain/`.

## Patrones para agregar cosas
**Nueva pantalla**
1. `features/<x>/presentation/screens/<nombre>_screen.dart` usando `ResponsiveLayout`.
2. Controller `AsyncNotifier` en `presentation/controllers/`.
3. Ruta en `app/router.dart` con guards necesarios.
4. Strings en `l10n/app_es.arb`.
5. Widget test + golden en 3 breakpoints.

**Nuevo endpoint**
1. DTOs + validación → controller → service → Prisma.
2. Guards: Auth, Roles, Ownership, Consent según el caso.
3. Actualizar `openapi.yaml` y regenerar el cliente Dart.
4. Test unitario del service + e2e.

**Nuevo test psicológico**
1. Agregar JSON en `assessments/definitions/<code>.v1.json` (ítems, opciones, scoring, reglas de seguridad).
2. Golden test de scoring con casos de referencia.
3. Marcar `self_administered` correctamente. Sin texto diagnóstico en bandas de resultado.

**Nuevo proveedor de IA/voz**
Implementar la interfaz (`LlmProvider`, `SttProvider`, `TtsProvider`), registrarla en el módulo, activarla por config. Correr evals y suite de crisis.

## Zonas protegidas (requieren confirmación humana explícita)
- `modules/safety/**`, `features/safety/**`, léxico de riesgo, textos de crisis.
- Prompts en producción.
- Textos legales y de consentimiento.
- Migraciones de BD y cifrado.
- Auth, guards, manejo de tokens.

## Prohibido
- Llamar APIs de IA desde la app.
- Guardar datos sensibles sin cifrar o en logs/analytics/push.
- Desactivar o saltar SafetyGate / ConsentGuard (incluso "temporalmente para probar").
- Escribir números de emergencia, citas clínicas o referencias legales de memoria.
- Generar textos que diagnostiquen.

## Al terminar
Ejecuta analyze + tests, revisa la Definition of Done (`10`), y resume: qué cambiaste, qué verificaste, qué queda pendiente o requiere validación humana.
