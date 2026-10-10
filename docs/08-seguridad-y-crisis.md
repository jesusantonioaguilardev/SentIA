# 08 · Seguridad del usuario y protocolo de crisis

> Este es el módulo más crítico. Todo lo marcado [VALIDAR-CLÍNICO] debe aprobarlo un profesional de salud mental antes de producción.

## Niveles de riesgo
| Nivel | Significado | Acción del sistema |
|---|---|---|
| 0 | Sin señales | Conversación normal |
| 1 | Malestar elevado / señales indirectas | IA responde con validación + ofrece recursos y ASQ; se registra `risk_event` |
| 2 | Ideación o señales de autolesión/violencia | **Respuesta determinística** de crisis (no generada), pantalla de ayuda con recursos, sugerir contacto inmediato; alerta a especialista vinculado (si existe) |
| 3 | Riesgo inminente (plan, medios, temporalidad) | Igual que 2 + notificación urgente a especialista y contacto de emergencia **si el usuario lo consintió** [VALIDAR-LEGAL]; la app muestra llamada directa a servicios de emergencia |

Correspondencia ASQ: no agudo → nivel 2, agudo/inminente → nivel 3 [VALIDAR-CLÍNICO].

## SafetyGate (backend `modules/safety`)
Evalúa **entrada y salida** de cada mensaje (texto, transcripción de voz, respuestas de tests, notas de mood):
1. Reglas determinísticas (léxico de riesgo en español, incluyendo modismos/escritura informal), versionadas.
2. Clasificador LLM/moderación con salida estructurada `{level, signals[], rationale}`.
3. Se toma el **máximo** de ambos (sesgo hacia la seguridad).
4. Si la salida del LLM viola reglas → se reemplaza por respuesta segura.

La app tiene una red local mínima (léxico) para mostrar ayuda **aunque no haya conexión**.

## Reglas de implementación
- El protocolo no depende del LLM para la respuesta de crisis: textos fijos, aprobados, localizados.
- No se puede desactivar por feature flag ni config.
- El botón de ayuda es visible en chat, voz y resultados.
- Nunca bloquear al usuario ni cerrar la conversación en crisis; mantener acompañamiento con mensajes fijos.
- Todo evento ≥ 1 → `risk_events` + `audit_log`.
- Alertas a especialistas con acuse de recibo y escalamiento si no se confirma [PENDIENTE: tiempos].

## Recursos de ayuda
Tabla `safety_resources` por país (MX en MVP). **Los números deben verificarse en fuentes oficiales antes de publicar** y revisarse periódicamente [VALIDAR-CLÍNICO]. Los agentes de IA no deben escribir números de teléfono de memoria.

**Disponibilidad offline:** como la pantalla de ayuda debe funcionar sin conexión, la app incluye una **copia empaquetada** de los recursos verificados (con `verified_at` y fuente), que se reemplaza por la versión de `GET /v1/safety/resources` cuando hay conexión. La copia empaquetada sigue la misma regla de verificación; nunca se rellena a mano sin fuente oficial.

## Lenguaje seguro {#lenguaje}
| ❌ Evitar | ✅ Usar |
|---|---|
| "Tienes depresión/ansiedad/TEPT" | "Tus respuestas muestran que podrías estar pasando por un momento difícil" |
| "Diagnóstico", "trastorno", "paciente enfermo" | "Resultado orientativo", "malestar", "lo que estás viviendo" |
| "Resultado: ansiedad severa" | "Tu puntuación es alta en esta escala; hablarlo con un profesional puede ayudarte" |
| "Cálmate", "no es para tanto" | "Tiene sentido que te sientas así" |
| "Soy tu terapeuta" | "Soy un asistente de IA; no sustituyo a un profesional" |

## Pruebas obligatorias
- `test/safety/scenarios/*.json`: ≥ 50 casos (directos, indirectos, sarcasmo, errores ortográficos, mezclas inglés-español, falsos positivos como "me muero de risa").
- Meta: recall 100 % en casos nivel ≥ 2; falsos positivos aceptables y monitoreados.
- Cualquier cambio en prompts, modelos, léxico o SafetyGate corre esta suite en CI.
- **Separar dos conjuntos:** `scenarios/tuning/` (se usa para ajustar léxico y prompts) y `scenarios/holdout/` (solo se evalúa, nunca se usa para ajustar; escrito o revisado por el responsable clínico). El criterio de salida se mide sobre *holdout*; 100 % sobre casos usados para ajustar no prueba generalización. Tamaño y umbral de falsos positivos: [PENDIENTE] (ver `12`).

## Tests psicológicos
| Test | Aplicación | Nota |
|---|---|---|
| ASQ | Autoaplicable | Positivo → protocolo |
| TQ | Autoaplicable | Puede evocar recuerdos difíciles: aviso previo + opción de pausar |
| TOP-8 | Autoaplicable | Últimos 7 días |
| HAM-A | Solo especialista | Heteroaplicada; sin puntos de corte (mayor puntaje = mayor intensidad) |

Verificar licencias/derechos de uso y versión validada en español de cada instrumento [VALIDAR-LEGAL/CLÍNICO].
