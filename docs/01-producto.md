# 01 · Producto

## Visión
SentIA es una app móvil de **apoyo emocional, autoconsciencia y acompañamiento conversacional asistido por IA**, con tests de tamizaje, perfil emocional dinámico y canal de escalamiento hacia profesionales humanos. Actúa como **herramienta complementaria**, nunca como atención clínica.

Tres dimensiones:
1. **Asistente conversacional** empático (texto → voz "modo llamada").
2. **Herramienta estructurada**: tests, registro emocional, seguimiento, metas.
3. **Plataforma** donde especialistas supervisan, reciben alertas y configuran pautas.

## Problema
Personas que necesitan expresar cómo se sienten, recibir contención y orientación inicial, registrar su estado emocional y hacer evaluaciones estructuradas, de forma privada, accesible y desde el móvil.

## Roles
| Rol | Etapa | Puede | No puede |
|---|---|---|---|
| **Usuario/paciente** | MVP | Registrarse, consentir, chatear, hacer tests, ver su historial y perfil, registrar ánimo, exportar/borrar sus datos | Ver datos de otros |
| **Familiar** | [ESC][PENDIENTE] | Acceso limitado autorizado por el paciente (a definir) | Ver conversaciones sin consentimiento explícito |
| **Especialista** | Etapa 4 | Ver pacientes vinculados (con consentimiento), alertas, métricas, notas, metas, umbrales | Ver pacientes no vinculados; diagnosticar vía la app |
| **Administrador** | Etapa 5 (mínimo en MVP) | Gestionar usuarios/roles, contenido RAG, prompts versionados, auditoría | Leer conversaciones sin motivo registrado (acceso auditado) |

Vinculación paciente↔especialista: **[PENDIENTE]** (código de invitación del especialista es la opción sugerida).

## Módulos funcionales
| Módulo | Descripción | Etapa |
|---|---|---|
| Autenticación | Registro, login, recuperación, cierre de sesión, MFA (especialista/admin), borrado de cuenta | 1 |
| Onboarding y consentimiento | Disclaimers de IA, aviso de privacidad, T&C, consentimiento expreso de datos sensibles, contacto de emergencia opcional | 1 |
| Chat con IA | Texto, streaming, memoria por usuario, historial | 2 |
| Seguridad / crisis | Detección de riesgo en cada mensaje, pantalla de ayuda, escalamiento | 2 (obligatorio antes de publicar) |
| Registro emocional (mood tracker) | Check-in diario, notas, tendencias | 2 |
| Tests de tamizaje | ASQ, TQ, TOP-8 (autoaplicables) · HAM-A (solo especialista) | 3 |
| Perfil emocional | Resumen evolutivo no diagnóstico | 3 |
| Voz "modo llamada" | STT/TTS, avatar animado que reacciona al hablar | 4 |
| Portal especialista | Web: alertas, timeline, notas, metas, umbrales | 4–5 |
| Notificaciones | Push / correo, auditadas | 3–4 |
| Administración | Usuarios, RAG, prompts, logs, métricas de uso | 5 |
| Reportes | Uso, temas recurrentes, cumplimiento (agregados) | 5 |
| Video / multimodal | Análisis facial/prosodia | 6 [PENDIENTE legal] |

## Límites (del Master Context)
**Sí:** apoyo emocional básico, escucha, técnicas seguras y delimitadas (respiración, grounding, psicoeducación validada), registro, detección de señales de riesgo para derivar.
**No:** diagnosticar, reemplazar terapia, atender emergencias sin protocolo de derivación, dar indicaciones clínicas, simular autoridad médica.

## Principios de UX
- Mobile-first, responsive teléfono/tablet/plegable; modo claro/oscuro; texto escalable.
- Identidad visual calmante: paleta neutral, tipografía legible, sin dark patterns ni gamificación compulsiva.
- Ayuda de crisis accesible **en máximo 1 toque** desde cualquier pantalla con chat.
- Lenguaje cálido, sin tecnicismos clínicos, en español de México [MVP]; i18n preparada.
