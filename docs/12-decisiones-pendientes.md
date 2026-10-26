# 12 · Decisiones pendientes

Ningún agente debe resolver estos puntos por su cuenta. Al decidir uno: muévelo a un ADR y actualiza los docs afectados.

## Producto
- [x] Usuario principal del MVP: público general → [ADR-0006](adr/0006-mvp-b2c.md).
- [x] Modelo de negocio del MVP: B2C → [ADR-0006](adr/0006-mvp-b2c.md). Monetización: [PENDIENTE].
- [ ] Alcance exacto del rol especialista y mecanismo de vinculación.
- [ ] Rol familiar (lo menciona una propuesta; no está en el Master Context).
- [ ] Escala del mood tracker (1–5 vs 0–10) y lista de emociones.
- [ ] Identidad visual final (paleta, tipografía, avatar).
- [ ] Portal web: Flutter Web vs Next.js.

## Técnica
- [ ] Proveedor de IA principal (OpenAI vs Gemini) y modelos por tarea.
- [ ] Proveedor de voz (OpenAI Realtime, ElevenLabs, Whisper+TTS).
- [ ] Nube/hosting y región de datos.
- [ ] Proveedor de push/correo y crash reporting.
- [ ] Offline: solo caché de lectura o escritura offline del chat.
- [ ] Versiones mínimas de Android/iOS.
- [ ] URLs de API de staging/prod (dependen del hosting); hoy son placeholders `.invalid` en `app/lib/core/config/app_config.dart`.
- [x] Monorepo (`app/` + `backend/`) → [ADR-0005](adr/0005-monorepo.md).
- [x] Bundle id base: `com.sentia.app` (dev: `.dev`, staging: `.staging`). Cambiarlo después de publicar en tiendas no es posible.
- [ ] Feature flags en MVP: config simple por entorno vs tabla `feature_flags` (prevista para Etapa 5).

## Clínica / ética
- [ ] Responsable clínico que apruebe prompts, textos de crisis y técnicas.
- [ ] Protocolo de crisis final y tiempos de escalamiento.
- [ ] Recursos de ayuda oficiales verificados.
- [ ] Reglas de activación de tests.
- [ ] Mapeo ASQ → niveles de riesgo.
- [ ] Licencias y versiones validadas en español de ASQ, TQ, TOP-8, HAM-A.
- [ ] Comité ético/clínico y frecuencia de revisión.
- [ ] Conjunto de evaluación de crisis *held-out* (no usado para ajustar léxico/prompts), escrito o revisado por el responsable clínico; tamaño objetivo (sugerido ≥ 200 casos) y umbral aceptable de falsos positivos.

## Legal
- [ ] Abogado que redacte aviso de privacidad, T&C, consentimientos.
- [ ] Plazos de retención por tipo de dato.
- [ ] Contacto de emergencia: base legal para notificarlo.
- [ ] Edad mínima y flujo para menores. En MVP la edad es **autodeclarada** (`birth_year`); confirmar que es suficiente y documentarlo como decisión consciente.
- [ ] Borrado de cuenta: propuesta en [ADR-0007](adr/0007-borrado-de-cuenta.md) (borrar contenido; conservar consentimiento y auditoría seudonimizados). **Falta validación legal y plazos de retención.**
- [ ] Si el portal de especialistas constituye expediente clínico (NOM-004/NOM-024).
