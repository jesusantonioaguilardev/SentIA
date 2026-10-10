# 03 · Arquitectura global

## Vista de componentes
```
┌──────────────────────────┐        ┌───────────────────────────────────────────────┐
│ App Flutter (iOS/Android)│ HTTPS  │ Backend NestJS (API Gateway lógico)           │
│  features/* (Riverpod)   │───────▶│  auth · users · consent · audit               │
│  cliente OpenAPI (dio)   │  WSS   │  chat · ai-gateway · safety · memory          │
│  secure storage          │◀──────▶│  assessments · profile · mood                 │
└──────────────────────────┘        │  voice · notifications · specialists · admin  │
┌──────────────────────────┐        │  knowledge (RAG)                              │
│ Portal web especialista/ │───────▶│                                               │
│ admin (Etapa 4–5)        │        └───────┬───────────────┬───────────────┬───────┘
└──────────────────────────┘                │               │               │
                                    ┌───────▼─────┐  ┌──────▼─────┐  ┌──────▼──────────┐
                                    │ PostgreSQL  │  │ Redis      │  │ Proveedores ext.│
                                    │ + pgvector  │  │ (cola,     │  │ LLM, STT/TTS,   │
                                    │ (cifrado)   │  │ rate-limit)│  │ push, correo    │
                                    └─────────────┘  └────────────┘  └─────────────────┘
```
Redis entra en Etapa 2 si hace falta rate limiting/colas; en MVP puede omitirse.

## Principios
1. **Cliente delgado y seguro**: la app nunca contiene secretos ni lógica clínica crítica; la detección de riesgo vive en el backend (la app solo tiene una red de seguridad local con palabras clave para mostrar ayuda offline).
2. **Contrato primero**: `openapi.yaml` en el backend es la fuente de verdad; el cliente Dart se genera. Cambiar la API = cambiar el contrato primero. Excepción práctica: el **streaming SSE/WS** del chat (y la voz) no lo cubre bien el codegen de Dart; ese cliente se escribe a mano en `core/network/` y se documenta su formato de eventos junto al contrato.
3. **Proveedores intercambiables**: `LlmProvider`, `SttProvider`, `TtsProvider`, `PushProvider` como interfaces; selección por configuración.
4. **Modular por dominio**: cada módulo (app y backend) es autocontenido; dependencias solo hacia `core/shared`.
5. **Seguridad por defecto**: deny-by-default en autorización (guards por rol + propiedad del recurso).
6. **Auditable**: toda acción sensible genera evento en `audit_log`.
7. **Feature flags** para activar módulos por etapa sin ramas largas.

## Flujo: mensaje de chat
```
App ──POST /chat/sessions/:id/messages──▶ ChatController
  1. AuthGuard + ConsentGuard
  2. SafetyGate.evaluate(input)            → nivel 0..3
     └─ nivel ≥2: respuesta de crisis fija + evento alerta + (nivel 3) notificar especialista/contacto
  3. MemoryService.buildContext(user)      → resumen + últimos N + perfil no sensible
  4. KnowledgeService.retrieve(input)      → fragmentos RAG (Etapa 5)
  5. AiGateway.stream(prompt)              → LlmProvider
  6. SafetyGate.evaluate(output)           → bloquea/reescribe respuestas no seguras
  7. Persistir (cifrado) + stream a la app (SSE/WS)
  8. Job asíncrono: actualizar resumen de memoria y señales de perfil
```
> El cifrado a nivel de campo protege los datos **en reposo**. En los pasos 2, 5, 6 y 8 el contenido viaja en claro (sobre TLS) al proveedor de LLM/moderación; esa transferencia debe declararse en el aviso de privacidad y cubrirse con contrato de encargado/DPA (ver [09](09-legal-y-cumplimiento.md)).

## Flujo: modo llamada (Etapa 4)
App ⇄ WSS `/voice` ⇄ VoiceGateway ⇄ (STT → SafetyGate → AiGateway → TTS) — o proveedor realtime nativo con SafetyGate sobre transcripción en paralelo y capacidad de cortar la sesión.

## Entornos
`dev` (local, Docker) · `staging` (datos sintéticos) · `prod`. Nunca datos reales fuera de prod.

## Hosting
[PENDIENTE] Proveedor cloud (AWS / GCP / Azure). Requisitos: PostgreSQL gestionado con cifrado en reposo, backups multi-zona, TLS 1.2+ (1.3 preferente), KMS para llaves. Si los datos se alojan fuera de México → declararlo en el aviso de privacidad (transferencias/remisiones).

## Evolución
- Monolito modular NestJS es suficiente hasta decenas de miles de usuarios. Si un módulo (voz, IA) requiere escalar distinto, se extrae como servicio sin cambiar el contrato.
- La capa `domain/` de la app es Dart puro (sin Flutter); el portal web (si se hace en Flutter Web) puede reutilizar dominio y cliente generado.
