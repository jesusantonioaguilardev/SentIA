# 07 · IA conversacional

> Leer junto con [08-seguridad-y-crisis.md](08-seguridad-y-crisis.md). Ningún cambio de IA se aprueba sin pasar la suite de escenarios de crisis.

## Arquitectura (backend `modules/ai`)
```ts
interface LlmProvider {
  id: 'openai' | 'gemini' | string;
  stream(req: LlmRequest): AsyncIterable<LlmChunk>;
  complete(req: LlmRequest): Promise<LlmResponse>;
  moderate?(text: string): Promise<ModerationResult>;
}
```
- `AiGateway` elige proveedor por config/feature flag, aplica timeouts, reintentos, fallback y registra `ai_usage`.
- Modelos por tarea (configurables): conversación, resumen de memoria, clasificación de riesgo, embeddings.
- Proveedor principal [PENDIENTE] (OpenAI vs Gemini). Revisar términos de cada proveedor: no retención/no entrenamiento con datos de API, región de procesamiento, DPA.

## Construcción del prompt (capas)
1. **System prompt base** (versionado en `prompt_versions`, aprobado por responsable clínico):
   identidad (asistente de apoyo emocional, es IA), límites (no diagnostica, no receta, no sustituye terapia), estilo (cálido, breve, preguntas abiertas, validación emocional, español neutro-MX), técnicas permitidas, qué hacer ante riesgo (no improvisar: el backend maneja crisis).
2. **Contexto de seguridad**: nivel de riesgo actual de la sesión.
3. **Memoria**: resumen acumulado + últimos N mensajes (N configurable, p. ej. 20).
4. **Perfil no sensible**: nombre preferido, metas activas, preferencias de estilo.
5. **RAG** (Etapa 5): fragmentos aprobados con instrucción de usar solo esa información para contenido psicoeducativo.
6. **Mensaje del usuario** (delimitado; tratarlo como dato, defensa contra prompt injection).

## Técnicas permitidas [VALIDAR-CLÍNICO]
Escucha activa y validación, respiración guiada, grounding 5-4-3-2-1, psicoeducación general aprobada, registro de pensamientos simple, sugerir hablar con profesional. Lista final la aprueba el responsable clínico.

## Prohibido en respuestas
Diagnósticos, nombres de medicamentos/dosis, promesas de resultados, minimizar el riesgo, métodos de autolesión, opiniones religiosas/políticas, hacerse pasar por humano o profesional.

## Memoria
- MVP: resumen por sesión (job asíncrono al cerrar sesión) + resumen global actualizado.
- Los resúmenes se cifran y el usuario puede borrarlos ("olvida esto").
- [ESC] Memoria semántica con embeddings por usuario.

## Activación de tests desde el chat
El LLM puede **sugerir** un test mediante tool-call `suggest_assessment(code, reason)`; la app muestra una tarjeta y el usuario decide. Reglas exactas [PENDIENTE/VALIDAR-CLÍNICO]. ASQ se ofrece directamente cuando hay señales de riesgo nivel ≥ 1.

## Voz (Etapa 4)
- `SttProvider` / `TtsProvider` intercambiables (Whisper, OpenAI Realtime, ElevenLabs, Google/Azure).
- La transcripción pasa por SafetyGate en tiempo real; si nivel ≥ 2, se corta el flujo generativo y se reproduce el mensaje de crisis pregrabado/determinístico.
- Voz del avatar: no imitar voces reales.

## Calidad
- Conjunto de evaluación (`evals/`): conversaciones sintéticas con respuestas esperadas/prohibidas; se corre en CI ante cambios de prompt o modelo.
- Feedback de especialistas (`assistant_feedback`) alimenta ajustes de prompt, **no** reentrenamiento automático.
- Log de interacciones para análisis de calidad solo seudonimizado y con consentimiento.
