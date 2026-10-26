# Diseño · "Serena & Calma"

Referencia visual de SentIA (recibida el 2026-10-25). Sistema de diseño: [DESIGN.md](DESIGN.md). Decisión: [ADR-0008](../adr/0008-identidad-visual.md).

Los `.html` son **prototipos** (Tailwind por CDN, imágenes de ejemplo): sirven para medir espaciados, textos y jerarquía, **no** para copiar código. Las capturas `.png` son la referencia visual.

## Pantallas y etapa en que se implementan

| Pantalla | Archivo | Etapa | Notas |
|---|---|---|---|
| Inicio de sesión | [app/login.png](app/login.png) | 1 | Ver §Revisión 3 (Google) |
| Inicio (home) | [app/home.png](app/home.png) | 1–2 | Registro de ánimo (2), actividades [VALIDAR-CLÍNICO] |
| Chat con asistente | [app/chat.png](app/chat.png) | 2 | Ver §Revisión 1 y 2 |
| Portal: dashboard | [portal/dashboard.png](portal/dashboard.png) | 4–5 | Portal web especialista |
| Portal: pacientes | [portal/pacientes.png](portal/pacientes.png) | 4 | |
| Portal: perfil de paciente | [portal/perfil-paciente.png](portal/perfil-paciente.png) | 4–5 | |
| Portal: evaluaciones | [portal/evaluaciones.png](portal/evaluaciones.png) | 3–5 | Ver §Revisión 5 |
| Portal: centro de alertas | [portal/alertas.png](portal/alertas.png) | 4 | |
| Portal: conversación de paciente | [portal/conversacion.png](portal/conversacion.png) | 4–5 | |
| Portal: reportes | [portal/reportes.png](portal/reportes.png) | 5 | |
| Portal: configuración | [portal/configuracion.png](portal/configuracion.png) | 4–5 | |

Logo: [logo.svg](logo.svg) → implementado como `app/lib/shared/widgets/sentia_logo.dart`.

## Qué ya está aplicado en la app
- Paleta completa (claro) y paleta oscura derivada: `app/lib/app/theme/app_colors.dart`.
- Tipografía (Plus Jakarta Sans, escala del diseño), formas de píldora, tarjetas con borde finísimo, campos, chips, navegación: `app/lib/app/theme/app_theme.dart`.
- Tokens de espaciado y radios: `app/lib/app/theme/tokens.dart`.
- Colores extra (privacidad, calma, avisos): `app/lib/app/theme/sentia_colors.dart`.
- Componentes: `SentiaLogo`, `PrivacyBadge`, barra inferior.

## Revisión: lo que NO se implementa tal como está dibujado
Los diseños son una propuesta visual; donde chocan con `docs/` (seguridad, legal, clínica) manda `docs/`. Cada punto requiere decisión o validación antes de implementarse.

1. **Avatar fotográfico del asistente** (chat, home). Una foto realista de una persona junto a "Asistente emocional / Disponible para escucharte" puede hacer creer que hay un humano detrás. docs/07 prohíbe hacerse pasar por humano y docs/09 exige el aviso de IA. Propuesta: avatar ilustrado o abstracto (p. ej. el logo) y rótulo explícito "Asistente de IA". **[PENDIENTE: decisión de producto]**
2. **Falta el botón de ayuda inmediata en el chat.** docs/08 lo exige siempre visible (máximo 1 toque). El ícono de escudo del encabezado puede ser ese botón ("Ayuda inmediata"). El aviso al pie del chat se conserva.
3. **"Continuar con Google"** (login). La Etapa 1 contempla solo correo y contraseña. Agregar Google implica otro proveedor de identidad, su consentimiento y su declaración en el aviso de privacidad. **[PENDIENTE]**
4. **Afirmaciones de cumplimiento y cifrado** (portal y app): "HIPAA / GDPR Certificado", "Contrato BAA", "Entorno Clínico Seguro Nivel IV", "Certificado por SentIA Trust Network", "FIDO2", "Cifrado de extremo a extremo / E2EE", "Cifrado de grado médico", y "Cifrado" en el diario. SentIA opera bajo la ley mexicana (docs/09), no tiene esas certificaciones y la arquitectura **no** es de extremo a extremo (el backend descifra para procesar con IA, docs/03). Mostrar algo así sería publicidad engañosa. Solo se muestran estados reales y verificables (p. ej. "Conexión segura", "2FA activado"). [VALIDAR-LEGAL]
5. **Instrumentos y lenguaje clínico en el portal.** Los diseños usan PHQ-9, GAD-7, PSS-10 y C-SSRS; docs/08 define ASQ, TQ, TOP-8 y HAM-A, con licencias por validar. El ASQ aparece como "para adolescentes", pero el MVP es solo para mayores de 18. Etiquetas como "Depresión Mayor", "Trastorno de Ansiedad Generalizada" o "Episodio de ansiedad laboral" son lenguaje diagnóstico; aun en el portal profesional deben salir de la escala validada, no del asistente. **[VALIDAR-CLÍNICO]**
6. **Inferencias de IA presentadas como hechos clínicos**: "Emoción detectada", "Indicadores somáticos", "marcadores biométricos de pánico", "análisis de prosodia", "algoritmo de triaje v2.4". Biometría y prosodia son de Etapa 6 y requieren evaluación de impacto (ADR-0004, docs/09 §5). En Etapas 2–5, lo que el portal muestre de la IA debe rotularse como orientativo. [VALIDAR-CLÍNICO/LEGAL]
7. **Actividades de bienestar** (Respiración 4-7-8, Reflexión consciente, Diario emocional): técnicas por aprobar (docs/07 §Técnicas permitidas). El diario no está en el roadmap. [VALIDAR-CLÍNICO] [PENDIENTE]
8. **Lista de emociones del registro** (Feliz, Tranquilo, Neutral, Triste, Ansioso, Enojado): coincide con el código actual, pero docs/12 tiene la escala y la lista como [PENDIENTE]. Confirmar.
9. **Voz** (micrófono en el chat, reproducir respuesta en voz): Etapa 4. En Etapa 2 se ocultan.
10. **Modo oscuro**: el diseño solo define el modo claro; la paleta oscura es derivada y debe validarse.
11. **Inconsistencias internas de DESIGN.md**: el texto menciona un fondo `#FAFBF9` y un primario `#3A6B88`, pero los tokens dicen `#F3FBFF` y `#1E536F`. Se siguen los **tokens**; los botones primarios usan `primary-container` (`#3A6B88`), como en los prototipos.
