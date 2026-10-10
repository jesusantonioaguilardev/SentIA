# ADR-0004: Alcance multimodal por etapas

- **Estado:** Aceptado
- **Fecha:** 2026-10-10

## Contexto
La cotización TECHX propone voz (opción 1) y voz + video con análisis facial (opción 2). El video implica datos biométricos y mayor riesgo legal y costo.

## Decisión
- Etapa 2: texto (MVP).
- Etapa 4: voz "modo llamada" con avatar animado.
- Etapa 6: video/análisis facial **solo** tras evaluación de impacto de privacidad y validación legal.

## Consecuencias
- MVP más rápido y seguro.
- La arquitectura de voz (WebSocket + proveedores intercambiables) se diseña para extenderse a video (WebRTC) sin reescritura.
