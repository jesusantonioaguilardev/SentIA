// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'SentIA';

  @override
  String get appTagline => 'Un espacio para hablar y sentirte acompañado.';

  @override
  String get privacyBadgePersonal => 'Tu espacio personal y seguro';

  @override
  String get breatheFooter => 'Tómate un respiro antes de continuar';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonLoading => 'Cargando…';

  @override
  String get navHome => 'Inicio';

  @override
  String get navChat => 'Chat';

  @override
  String get navHistory => 'Historial';

  @override
  String get navProfile => 'Perfil';

  @override
  String get statusTitle => 'Hola, soy SentIA';

  @override
  String get statusSubtitle => 'Estado de la conexión con el servidor';

  @override
  String statusEnvironment(String flavor) {
    return 'Entorno: $flavor';
  }

  @override
  String get statusServerOk => 'Servidor disponible';

  @override
  String get statusServerDegraded =>
      'El servidor responde, pero la base de datos no está disponible';

  @override
  String get statusChecking => 'Comprobando conexión…';

  @override
  String get statusRetry => 'Reintentar';

  @override
  String get errorNetwork =>
      'No hay conexión. Revisa tu internet e inténtalo de nuevo.';

  @override
  String get errorServer =>
      'Algo salió mal de nuestro lado. Inténtalo en unos minutos.';

  @override
  String get errorUnexpected =>
      'Ocurrió un error inesperado. Inténtalo de nuevo.';

  @override
  String get welcomeWhatTitle => 'Qué es SentIA';

  @override
  String get welcomeWhatBody =>
      'Un espacio de acompañamiento emocional con inteligencia artificial. Está pensado para escucharte, ayudarte a ordenar tus pensamientos y sugerirte ejercicios de bienestar.';

  @override
  String get welcomeWhatNotTitle => 'Qué no es';

  @override
  String get welcomeWhatNotBody =>
      'SentIA no es un psicólogo ni un servicio de emergencias, no hace diagnósticos y no sustituye la atención de un profesional. Las respuestas las genera una IA y pueden contener errores.';

  @override
  String get welcomeHelpTitle => 'Ayuda cuando la necesites';

  @override
  String get welcomeHelpBody =>
      'Si en algún momento estás en peligro o en crisis, toca el escudo en la parte superior para ver líneas de ayuda que puedes llamar de inmediato.';

  @override
  String get welcomeCreateAccount => 'Crear cuenta';

  @override
  String get welcomeHaveAccount => 'Ya tengo cuenta';

  @override
  String get authEmailLabel => 'Correo electrónico';

  @override
  String get authEmailHint => 'tu@correo.com';

  @override
  String get authPasswordLabel => 'Contraseña';

  @override
  String get authShowPassword => 'Mostrar contraseña';

  @override
  String get authHidePassword => 'Ocultar contraseña';

  @override
  String get authForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authLoginButton => 'Iniciar sesión';

  @override
  String get authNoAccount => '¿No tienes una cuenta?';

  @override
  String get authCreateAccount => 'Crear cuenta';

  @override
  String get authHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get authLoginLink => 'Inicia sesión';

  @override
  String get signupTitle => 'Crea tu cuenta';

  @override
  String get signupSubtitle => 'Solo te pedimos lo necesario.';

  @override
  String get signupPasswordHelp =>
      'Usa al menos 12 caracteres. Una frase que recuerdes funciona bien.';

  @override
  String get signupConfirmPasswordLabel => 'Repite la contraseña';

  @override
  String get signupBirthYearLabel => 'Año de nacimiento';

  @override
  String get signupAgeConfirm => 'Confirmo que tengo 18 años o más';

  @override
  String get signupButton => 'Crear cuenta';

  @override
  String get forgotTitle => 'Recupera tu acceso';

  @override
  String get forgotBody =>
      'Escribe tu correo y te enviaremos un enlace para crear una nueva contraseña.';

  @override
  String get forgotButton => 'Enviar enlace';

  @override
  String get forgotSentTitle => 'Revisa tu correo';

  @override
  String get forgotSentBody =>
      'Si existe una cuenta con ese correo, te enviamos un enlace. Vence en 30 minutos.';

  @override
  String get forgotBackToLogin => 'Volver a iniciar sesión';

  @override
  String get validationEmail => 'Escribe un correo válido';

  @override
  String get validationPasswordLength => 'Debe tener al menos 12 caracteres';

  @override
  String get validationRequired => 'Este campo es obligatorio';

  @override
  String get validationPasswordsDiffer => 'Las contraseñas no coinciden';

  @override
  String get validationBirthYear => 'Escribe un año válido';

  @override
  String get validationAgeConfirm => 'Debes confirmar que eres mayor de edad';

  @override
  String get authErrorInvalidCredentials => 'Correo o contraseña incorrectos.';

  @override
  String get authErrorEmailTaken => 'Ya existe una cuenta con ese correo.';

  @override
  String get authErrorUnderage =>
      'SentIA es solo para personas de 18 años o más.';

  @override
  String get authErrorLocked =>
      'Demasiados intentos. Espera unos minutos e inténtalo de nuevo.';

  @override
  String get authErrorValidation => 'Revisa los datos e inténtalo de nuevo.';

  @override
  String get consentTitle => 'Antes de empezar';

  @override
  String get consentSubtitle =>
      'Lee y acepta cómo cuidamos tu información. Puedes revisar o retirar tu consentimiento en Ajustes.';

  @override
  String get consentDraftBanner =>
      'BORRADOR — pendiente de revisión legal. Estos textos cambiarán antes del lanzamiento.';

  @override
  String get consentRequired => 'Obligatorio';

  @override
  String get consentOptional => 'Opcional';

  @override
  String get consentAcceptRequired => 'Acepto';

  @override
  String get consentAcceptOptional => 'Sí, autorizo';

  @override
  String get consentReadDocument => 'Leer documento completo';

  @override
  String consentVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get consentAcceptButton => 'Aceptar y continuar';

  @override
  String get consentSignOut => 'Cerrar sesión';

  @override
  String get helpTitle => 'Ayuda inmediata';

  @override
  String get helpCrisisButton => 'Ayuda inmediata';

  @override
  String get helpIntro =>
      'Si estás en peligro o piensas en hacerte daño, no estás solo. Llama ahora a alguno de estos servicios.';

  @override
  String helpCall(String phone) {
    return 'Llamar al $phone';
  }

  @override
  String helpHours(String hours) {
    return 'Horario: $hours';
  }

  @override
  String helpVerified(String date) {
    return 'Verificado en fuente oficial el $date';
  }

  @override
  String get helpOpenSource => 'Ver fuente oficial';

  @override
  String get helpPendingClinical =>
      'Pendiente de validación clínica (visible solo fuera de producción)';

  @override
  String get helpOfflineNote =>
      'Sin conexión: mostramos la lista guardada en tu teléfono.';

  @override
  String get helpCallFailed =>
      'No pudimos abrir el marcador. Marca el número manualmente.';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileDisplayNameLabel => '¿Cómo quieres que te llamemos?';

  @override
  String get profileEmergencyTitle => 'Contacto de emergencia (opcional)';

  @override
  String get profileEmergencyBody =>
      'Alguien de confianza. Antes de registrarlo, avísale que lo harás. Se guarda cifrado.';

  @override
  String get profileEmergencyName => 'Nombre';

  @override
  String get profileEmergencyPhone => 'Teléfono';

  @override
  String get profileEmergencyRemove => 'Quitar contacto';

  @override
  String get profileSaved => 'Cambios guardados';

  @override
  String get profileSettings => 'Ajustes y privacidad';

  @override
  String get validationPhone => 'Escribe un teléfono válido';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsTextSize => 'Tamaño del texto';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageValue => 'Español (México)';

  @override
  String get settingsPrivacy => 'Privacidad y consentimientos';

  @override
  String get settingsConsentGranted => 'Aceptado';

  @override
  String get settingsConsentNotGranted => 'No aceptado';

  @override
  String get settingsRevokeTitle => '¿Retirar este consentimiento?';

  @override
  String get settingsRevokeRequiredBody =>
      'Este consentimiento es necesario para usar SentIA. Si lo retiras, tendrás que aceptarlo de nuevo para continuar, o puedes eliminar tu cuenta.';

  @override
  String get settingsRevokeOptionalBody =>
      'Dejaremos de usar tus datos para este fin.';

  @override
  String get settingsRevoke => 'Retirar';

  @override
  String get settingsData => 'Tus datos';

  @override
  String get settingsExport => 'Exportar mis datos';

  @override
  String get settingsExportBody =>
      'Descarga una copia de todo lo que guardamos sobre ti (formato JSON).';

  @override
  String get settingsExportShareText => 'Mis datos de SentIA';

  @override
  String get settingsSession => 'Sesión';

  @override
  String get settingsLogout => 'Cerrar sesión';

  @override
  String get settingsLogoutAll => 'Cerrar sesión en todos los dispositivos';

  @override
  String get settingsLogoutAllDone =>
      'Cerramos tu sesión en todos los dispositivos.';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String get settingsDeleteTitle => '¿Eliminar tu cuenta?';

  @override
  String get settingsDeleteBody =>
      'Se borrarán tu perfil, tus conversaciones y tus registros. Esta acción no se puede deshacer. Solo conservaremos, sin datos de contacto, la evidencia de tus consentimientos y la bitácora de seguridad que exige la ley.';

  @override
  String get settingsDeletePassword => 'Escribe tu contraseña para confirmar';

  @override
  String get settingsDeleteConfirm => 'Eliminar definitivamente';

  @override
  String get settingsServerStatus => 'Estado del servidor';

  @override
  String settingsLegalVersion(String version) {
    return 'Documentos legales: versión $version';
  }
}
