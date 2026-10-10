# 02 · Roadmap por etapas

Cada etapa termina en algo **funcional, probado y desplegable**. No se avanza sin cumplir los criterios de salida.
Duraciones orientativas para 1 desarrollador con apoyo de IA; ajustar.

**Etapa activa: 0**

---

## Etapa 0 · Fundaciones (1–2 semanas)
**Objetivo:** esqueleto profesional sobre el que todo lo demás crece sin reescrituras.

App (Flutter):
- [ ] Estructura `lib/app`, `lib/core`, `lib/features`, `lib/shared`, `lib/l10n` ([04](04-app-flutter.md)).
- [ ] Flavors `dev`, `staging`, `prod` (bundle ids y endpoints distintos).
- [ ] Dependencias base: riverpod, go_router, dio, freezed, json_serializable, flutter_secure_storage, intl.
- [ ] Theme Material 3 claro/oscuro + tokens de diseño; `ResponsiveLayout` con breakpoints.
- [ ] i18n con ARB (`es` por defecto).
- [ ] `analysis_options.yaml` estricto (very_good_analysis o flutter_lints + reglas extra).
- [ ] Manejo global de errores (`Result`/`Failure`), logger con redacción de datos sensibles.
- [ ] Migrar el código existente (anterior a estos docs) a la estructura de [04](04-app-flutter.md); inventario de deuda en `CLAUDE.md`.

Backend (NestJS):
- [ ] Repo `sentia-backend`, módulos vacíos `auth`, `users`, `health`; Prisma + PostgreSQL; Docker Compose local.
- [ ] Config por entorno validada (zod/class-validator), Swagger/OpenAPI en `/docs`.
- [ ] `openapi.yaml` publicado → cliente Dart generado en la app.

Transversal:
- [ ] Repositorio git inicializado (prerrequisito de CI).
- [ ] CI: analyze + test + build en cada PR (GitHub Actions).
- [x] `AGENTS.md`, `CLAUDE.md`, `docs/`, ADRs 0001–0004.

**Criterio de salida:** app compila en los 3 flavors, muestra pantalla "Hola" responsive en teléfono y tablet, llama `GET /health` del backend; CI en verde.

---

## Etapa 1 · Cuenta, onboarding y cumplimiento legal base (2–3 semanas)
- [ ] Registro/login email+contraseña (argon2 en backend), JWT access 15 min + refresh rotativo en secure storage.
- [ ] Recuperación de contraseña, cierre de sesión en todos los dispositivos.
- [ ] Verificación de edad: **solo mayores de 18 en MVP** [VALIDAR-LEGAL] (menores = flujo de tutor, [ESC]).
- [ ] Onboarding: qué es / qué no es SentIA, disclaimer de IA, aviso de privacidad, T&C, **consentimiento expreso** para datos sensibles (versionado y registrado).
- [ ] Pantalla "Ayuda inmediata" con recursos de crisis [VALIDAR-CLÍNICO: números oficiales].
- [ ] Perfil básico + contacto de emergencia opcional (con consentimiento del tercero informado).
- [ ] **Borrado de cuenta in-app** + solicitud web de borrado (requisito Apple y Google Play).
- [ ] Exportar mis datos (JSON) — derechos ARCO.
- [ ] Ajustes: tema, tamaño de texto, idioma, cerrar sesión, privacidad.
- [ ] Backend: módulos `auth`, `users`, `consent`, `audit` (log append-only).

**Criterio de salida:** un usuario se registra, consiente, edita perfil, exporta y borra su cuenta; todo auditado; tests de auth > 80 % cobertura.

---

## Etapa 2 · Chat con IA + seguridad (MVP núcleo) (3–4 semanas)
- [ ] `AiGateway` en backend con interfaz `LlmProvider` (OpenAI y Gemini intercambiables por config).
- [ ] Prompt de sistema versionado en BD/archivo, con reglas de seguridad ([07](07-ia-conversacional.md)).
- [ ] Chat por texto con streaming (SSE o WebSocket), reintentos, estado offline.
- [ ] Historial de conversaciones; memoria básica (resumen por sesión + últimos N mensajes).
- [ ] **SafetyGate** en cada mensaje entrante y saliente: clasificador de riesgo (reglas + LLM moderación) → niveles 0–3 ([08](08-seguridad-y-crisis.md)).
- [ ] Respuesta de crisis determinística (no generada) + botón de ayuda siempre visible.
- [ ] Mood tracker: check-in diario (escala + emociones + nota), gráfica de 7/30 días.
- [ ] Rate limiting y límites de costo por usuario.
- [ ] Cifrado a nivel de campo del contenido de mensajes.

**Criterio de salida:** conversación fluida; suite de **escenarios de crisis** (≥ 50 casos sintéticos) detectados al 100 % en nivel ≥ 2; nada sensible en logs. **Este es el MVP publicable (beta cerrada).**

---

## Etapa 3 · Tests de tamizaje y perfil emocional (3 semanas)
- [ ] Motor de cuestionarios **data-driven** (definición JSON: ítems, opciones, scoring, reglas) — agregar un test = agregar un JSON.
- [ ] ASQ (riesgo suicida → si positivo activa protocolo), TQ, TOP-8. Verificar licencias de uso [VALIDAR-LEGAL].
- [ ] HAM-A solo en portal de especialista (heteroaplicada).
- [ ] Resultados con lenguaje orientativo + "comparte esto con un profesional".
- [ ] Reglas de activación sugerida de tests según contexto (el usuario siempre decide) [PENDIENTE: reglas exactas, VALIDAR-CLÍNICO].
- [ ] Perfil emocional: tendencias de ánimo, temas frecuentes, resultados en el tiempo — sin etiquetas diagnósticas.
- [ ] Notificaciones push de recordatorio (sin contenido sensible).

**Criterio de salida:** los 3 tests calculan igual que la hoja de referencia (tests golden); ASQ positivo dispara protocolo en 100 % de casos.

---

## Etapa 4 · Voz "modo llamada" + especialista básico (4–6 semanas)
- [ ] Modo llamada: audio bidireccional por WebSocket; STT/TTS en backend (OpenAI Realtime / ElevenLabs / Whisper, intercambiables).
- [ ] Avatar animado que reacciona cuando habla el agente (Rive/Lottie), con alternativa de movimiento reducido.
- [ ] SafetyGate aplicado sobre la transcripción en tiempo real; interrupción amable y transferencia.
- [ ] Subtítulos en vivo (accesibilidad).
- [ ] Grabaciones **solo con consentimiento específico**; retención definida [PENDIENTE].
- [ ] Rol especialista: vinculación con paciente, lista de pacientes, alertas, timeline (portal web Flutter Web o Next.js [PENDIENTE]).
- [ ] MFA obligatorio para especialistas.

**Criterio de salida:** latencia de respuesta de voz < 1.5 s p50; especialista recibe alerta de nivel 3 en < 60 s.

---

## Etapa 5 · Portal clínico completo, admin y RAG (4–6 semanas)
- [ ] Portal especialista: métricas, notas, metas terapéuticas que el paciente ve en la app, umbrales de alerta configurables, calificar respuestas del asistente.
- [ ] Panel admin: usuarios/roles, prompts versionados, feature flags, auditoría, métricas de uso agregadas.
- [ ] RAG: base de conocimiento curada (pgvector), indexación, versionado, flujo de aprobación por comité clínico.
- [ ] Notificaciones multicanal (push, correo) con historial auditado y acuse de recibo.
- [ ] Reportes agregados/anonimizados.
- [ ] Rol familiar [PENDIENTE].

---

## Etapa 6 · Escala y multimodal [ESC]
- [ ] Videollamada con agente (WebRTC), análisis facial/prosodia — **solo tras evaluación de impacto de privacidad y validación legal (datos biométricos)**.
- [ ] Opción de enmascaramiento/borrado de rostro.
- [ ] Multi-región, réplicas, autoscaling, pruebas de carga.
- [ ] Certificaciones/adecuaciones GDPR/HIPAA si se expande.
- [ ] Analítica emocional longitudinal avanzada.

---

## Transversal en todas las etapas
- Accesibilidad AA, responsive, i18n, pruebas, auditoría, ADRs, actualización de `docs/`.
- Revisión de cumplimiento de tiendas antes de cada release ([09](09-legal-y-cumplimiento.md)).
