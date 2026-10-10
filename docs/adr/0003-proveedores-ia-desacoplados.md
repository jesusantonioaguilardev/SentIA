# ADR-0003: Proveedores de IA y voz desacoplados vía backend

- **Estado:** Aceptado
- **Fecha:** 2026-10-10

## Contexto
Se han considerado Gemini, OpenAI, ElevenLabs, Whisper, Azure Speech. Los costos y la calidad cambian; las API keys no pueden vivir en el cliente.

## Decisión
- La app solo habla con el backend.
- Backend define interfaces `LlmProvider`, `SttProvider`, `TtsProvider`; selección por configuración/feature flag; fallback automático.
- Todo tráfico de IA pasa por `SafetyGate` antes y después.

## Consecuencias
- Cambiar de proveedor no toca la app.
- Mayor latencia mínima por el salto extra (aceptable; se mitiga con streaming).
