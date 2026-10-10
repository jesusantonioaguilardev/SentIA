# 12 · Decisiones pendientes

Ningún agente debe resolver estos puntos por su cuenta. Al decidir uno: muévelo a un ADR y actualiza los docs afectados.

## Producto
- [ ] Usuario principal del MVP (público general vs pacientes de una clínica específica).
- [ ] Cliente directo y modelo de negocio (B2C, B2B a clínicas, licencia). **Bloqueante para Etapa 1**: si es B2B, el rol especialista, la vinculación y el responsable de los datos cambian desde el inicio.
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
- [ ] Monorepo (`app/` + `backend/`) vs dos repos (ADR-0002 dice repo separado). Monorepo simplifica contrato, CI y contexto para agentes con 1 desarrollador.
- [ ] Bundle id / dominio base (hoy `com.example.sentia2`) — necesario para flavors en Etapa 0.
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
- [ ] Borrado de cuenta vs `audit_log` append-only y evidencia de consentimiento: qué se elimina, qué se anonimiza y qué se conserva (y cuánto). **Bloqueante para Etapa 1.**
- [ ] Si el portal de especialistas constituye expediente clínico (NOM-004/NOM-024).
