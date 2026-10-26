# ADR-0007: Alcance del borrado de cuenta

- **Estado:** Propuesto — pendiente de validación legal [VALIDAR-LEGAL]
- **Fecha:** 2026-10-25

## Contexto
Apple y Google exigen borrado de cuenta in-app y por web (docs/09). A la vez, `audit_log` es append-only y la evidencia de consentimiento puede tener que conservarse. `docs/12` lo marcaba como bloqueante para Etapa 1.

## Decisión (propuesta)
Al borrar una cuenta (`DELETE /v1/me`, docs/05):
- **Se elimina**: perfil, contacto de emergencia, conversaciones y resúmenes, registros de ánimo, respuestas de tests, perfil emocional, tokens y dispositivos.
- **Se conserva**, seudonimizado (sin correo ni datos de contacto, ligado a un identificador interno): la evidencia de consentimiento (`user_consents`: documento, versión, fecha) y el `audit_log`.
- Plazo de retención de lo conservado: [PENDIENTE / VALIDAR-LEGAL].
- El borrado se ejecuta en ≤ 30 días desde la solicitud [VALIDAR-LEGAL plazo]; la cuenta queda inaccesible de inmediato.

## Alternativas
- Borrado total, incluida la auditoría: más simple, pero puede impedir demostrar consentimiento o atender requerimientos legales.
- Esperar la opinión legal: bloquea Etapa 1.

## Consecuencias
- El modelo de datos de Etapa 1 separa identidad (borrable) de evidencia (seudonimizada).
- Antes de producción, un abogado debe confirmar qué se conserva y por cuánto tiempo.
