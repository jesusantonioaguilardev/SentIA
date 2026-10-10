# 09 · Legal y cumplimiento

> Esto es una guía técnica para diseñar el producto, **no asesoría legal**. Todo lo aquí descrito debe validarlo un abogado especializado en protección de datos y salud digital antes de publicar. [VALIDAR-LEGAL]

## 1. México — Protección de datos personales
- **Ley aplicable:** Ley Federal de Protección de Datos Personales en Posesión de los Particulares (**nueva ley publicada en el DOF el 20-mar-2025**, que reemplazó a la de 2010). La autoridad de vigilancia dejó de ser el INAI; confirmar autoridad competente y reglamento vigente con el abogado.
- Datos de salud y emocionales = **datos personales sensibles** → requieren **consentimiento expreso** (y por escrito/firma electrónica según el caso) para su tratamiento.
- Obligaciones a implementar:
  | Obligación | Implementación en SentIA | Etapa |
  |---|---|---|
  | Aviso de privacidad (integral y simplificado) | Pantalla en onboarding + URL pública; versionado en `consent_documents` | 1 |
  | Consentimiento expreso para sensibles | Checkbox no premarcado + registro con versión, fecha y app_version | 1 |
  | Finalidades primarias vs secundarias | Secundarias (p. ej. mejora del modelo, investigación) con opt-in separado | 1 |
  | Derechos ARCO (acceso, rectificación, cancelación, oposición) | Exportar datos, editar perfil, borrar cuenta, oponerse a finalidades secundarias; tabla `data_requests` | 1 |
  | Revocación del consentimiento | Ajustes > Privacidad | 1 |
  | Medidas de seguridad administrativas, técnicas y físicas | Cifrado, control de acceso, auditoría, plan de respuesta a incidentes | 1–2 |
  | Notificación de vulneraciones | Procedimiento documentado | 2 |
  | Transferencias / remisiones (proveedores de IA, nube) | Listar en aviso de privacidad; contratos de encargado (DPA) | 2 |
- **Menores de edad:** MVP solo +18 hasta tener flujo de consentimiento de tutor validado.

## 2. Salud
- Al no diagnosticar ni tratar, SentIA busca **no** ser un dispositivo médico/software como dispositivo médico. Si en el futuro diagnostica, recomienda tratamientos o se usa como expediente clínico, revisar: COFEPRIS (software como dispositivo médico), NOM-004-SSA3-2012 (expediente clínico), NOM-024-SSA3-2012 (sistemas de información de registro electrónico para la salud). [VALIDAR-LEGAL]
- El portal de especialistas con notas clínicas puede acercarse a expediente clínico → evaluar en Etapa 4.
- Especialistas: verificar cédula profesional (`license_verified_at`).

## 3. Tiendas de aplicaciones
**Google Play**
- Formulario de **declaración de apps de salud** (Health apps declaration) en Play Console.
- Sección **Seguridad de los datos** (Data safety) completa y coherente con el aviso de privacidad.
- **Borrado de cuenta**: dentro de la app y mediante un enlace web.
- Política de privacidad accesible en la ficha y en la app.
- Política de contenido sobre autolesión: la app no debe promoverla; los recursos de ayuda refuerzan cumplimiento.
- Target API level vigente exigido por Play.

**Apple App Store**
- Guideline 1.4.1 (apps de salud/médicas: no afirmar precisión diagnóstica sin validación) y 5.1.1 / 5.1.3 (datos de salud, privacidad, **borrado de cuenta in-app**).
- Privacy Nutrition Labels y Privacy Manifest (`PrivacyInfo.xcprivacy`) con APIs y SDKs declarados.
- Permisos (micrófono, notificaciones, cámara en Etapa 6) con textos de propósito claros.

Checklist de release en [10-calidad-y-pruebas.md](10-calidad-y-pruebas.md#release).

## 4. Expansión internacional [ESC]
- **GDPR (UE):** datos de salud = categoría especial (art. 9); DPIA obligatoria, base legal, DPO, transferencias internacionales.
- **HIPAA (EE. UU.):** aplica si se trabaja con *covered entities* (p. ej. clínicas); BAA con proveedores.
- Ley de IA de la UE: revisar clasificación si se expande.

## 5. Biometría y video (Etapa 6)
Análisis facial y de voz para inferir emociones implica datos biométricos/sensibles adicionales: evaluación de impacto de privacidad, consentimiento específico, minimización (procesar sin almacenar cuando sea posible), opción de enmascarar rostro. No iniciar sin validación legal.

## 6. Documentos legales necesarios (entregables)
- Aviso de privacidad integral y simplificado.
- Términos y condiciones (incluye: no sustituye atención profesional, no es servicio de emergencias, uso de IA, edad mínima).
- Disclaimer de IA en salud mental (onboarding y antes de interacciones sensibles).
- Consentimiento para grabaciones de voz (Etapa 4) y para compartir con especialista.
- Contratos de encargado con proveedores (IA, nube, push, correo).
- Política de retención y borrado.
- Plan de respuesta a incidentes de seguridad.
- Comité ético/clínico: revisión periódica de prompts, RAG y conversaciones muestreadas (con consentimiento).
