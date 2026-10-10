// Zona protegida (docs/11): estos textos no se reformatean ni editan sin
// revisión legal; por eso se tolera el largo de línea.
// TODO(legal): textos provisionales; el número de emergencia debe venir de
// recursos verificados (docs/08), no escrito a mano.
// ignore_for_file: lines_longer_than_80_chars

class LegalTexts {
  static const String privacyNotice = '''
# AVISO DE PRIVACIDAD — SentIA

Última actualización: [Fecha]

## 1. Identidad y domicilio del responsable
[Nombre/Razón Social], con domicilio en [Domicilio], es responsable del tratamiento de tus datos personales conforme a la LFPDPPP.

## 2. Datos personales que recabamos
### 2.1 Datos de identificación y contacto
Nombre, correo electrónico y contraseña (cifrada).
### 2.2 Datos sensibles (Salud)
SentIA trata datos personales sensibles: estados emocionales, contenido de conversaciones y entradas de diario. El tratamiento requiere tu consentimiento expreso.

## 3. Finalidades del tratamiento
Primarias: Brindar acompañamiento emocional, seguimiento de bienestar y métricas para profesionales autorizados.
Secundarias: Mejora de modelos de IA e investigación estadística (anonimizada).

... [Ver documento completo para Derechos ARCO y Transferencias] ...
''';

  static const String termsAndConditions = '''
# TÉRMINOS Y CONDICIONES DE USO — SentIA

## 1. Aceptación de los términos
Al usar SentIA, aceptas estos términos. Si no estás de acuerdo, no uses la app.

## 2. Descripción del servicio y límites
SentIA es una herramienta de acompañamiento emocional con IA. 
**NO ES UN SUSTITUTO DE DIAGNÓSTICO MÉDICO O PSICOLÓGICO PROFESIONAL.**

**SI ESTÁS EN UNA SITUACIÓN DE CRISIS O RIESGO, LLAMA AL 911 O A UNA LÍNEA DE EMERGENCIA INMEDIATAMENTE.**

## 3. Uso aceptable
No suplantar identidad ni intentar obtener diagnósticos médicos formales.
''';

  static const String informedConsentStep1 =
      'SentIA es un espacio de acompañamiento emocional con inteligencia artificial. No reemplaza a un psicólogo ni realiza diagnósticos. Está diseñado para escucharte, ayudarte a organizar tus pensamientos y sugerirte ejercicios de bienestar — no para tratar condiciones de salud mental.';

  static const String informedConsentStep2 =
      'Entiendo que las conversaciones, mis estados emocionales registrados y mis entradas de diario pueden considerarse datos sensibles relacionados con mi salud, y autorizo expresamente a SentIA a procesarlos con el único fin de brindarme el servicio de acompañamiento descrito en el Aviso de Privacidad.';

  static const String informedConsentStep3 =
      'Entiendo que SentIA no sustituye atención médica ni psicológica profesional, que las respuestas del asistente son generadas por IA y pueden contener errores, y que en caso de crisis debo contactar servicios de emergencia o a un profesional de la salud, no depender de esta aplicación.';

  static const String informedConsentStep4 =
      'Autorizo a SentIA a compartir mis métricas de estado emocional y alertas configuradas con el profesional de salud que yo vincule explícitamente a mi cuenta. Puedo revocar esta autorización en cualquier momento.';

  static const String informedConsentStep5 =
      'Autorizo el uso de mis datos, de forma anonimizada y agregada, para mejorar los modelos de IA y la investigación estadística del producto.';
}
