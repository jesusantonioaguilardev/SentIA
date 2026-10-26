import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'SentIA'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In es, this message translates to:
  /// **'Un espacio para hablar y sentirte acompañado.'**
  String get appTagline;

  /// No description provided for @privacyBadgePersonal.
  ///
  /// In es, this message translates to:
  /// **'Tu espacio personal y seguro'**
  String get privacyBadgePersonal;

  /// No description provided for @breatheFooter.
  ///
  /// In es, this message translates to:
  /// **'Tómate un respiro antes de continuar'**
  String get breatheFooter;

  /// No description provided for @commonContinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get commonContinue;

  /// No description provided for @commonBack.
  ///
  /// In es, this message translates to:
  /// **'Atrás'**
  String get commonBack;

  /// No description provided for @commonCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get commonSave;

  /// No description provided for @commonRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get commonRetry;

  /// No description provided for @commonClose.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get commonClose;

  /// No description provided for @commonLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando…'**
  String get commonLoading;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navChat.
  ///
  /// In es, this message translates to:
  /// **'Chat'**
  String get navChat;

  /// No description provided for @navHistory.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get navHistory;

  /// No description provided for @navProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @statusTitle.
  ///
  /// In es, this message translates to:
  /// **'Hola, soy SentIA'**
  String get statusTitle;

  /// No description provided for @statusSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Estado de la conexión con el servidor'**
  String get statusSubtitle;

  /// No description provided for @statusEnvironment.
  ///
  /// In es, this message translates to:
  /// **'Entorno: {flavor}'**
  String statusEnvironment(String flavor);

  /// No description provided for @statusServerOk.
  ///
  /// In es, this message translates to:
  /// **'Servidor disponible'**
  String get statusServerOk;

  /// No description provided for @statusServerDegraded.
  ///
  /// In es, this message translates to:
  /// **'El servidor responde, pero la base de datos no está disponible'**
  String get statusServerDegraded;

  /// No description provided for @statusChecking.
  ///
  /// In es, this message translates to:
  /// **'Comprobando conexión…'**
  String get statusChecking;

  /// No description provided for @statusRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get statusRetry;

  /// No description provided for @errorNetwork.
  ///
  /// In es, this message translates to:
  /// **'No hay conexión. Revisa tu internet e inténtalo de nuevo.'**
  String get errorNetwork;

  /// No description provided for @errorServer.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal de nuestro lado. Inténtalo en unos minutos.'**
  String get errorServer;

  /// No description provided for @errorUnexpected.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error inesperado. Inténtalo de nuevo.'**
  String get errorUnexpected;

  /// No description provided for @welcomeWhatTitle.
  ///
  /// In es, this message translates to:
  /// **'Qué es SentIA'**
  String get welcomeWhatTitle;

  /// No description provided for @welcomeWhatBody.
  ///
  /// In es, this message translates to:
  /// **'Un espacio de acompañamiento emocional con inteligencia artificial. Está pensado para escucharte, ayudarte a ordenar tus pensamientos y sugerirte ejercicios de bienestar.'**
  String get welcomeWhatBody;

  /// No description provided for @welcomeWhatNotTitle.
  ///
  /// In es, this message translates to:
  /// **'Qué no es'**
  String get welcomeWhatNotTitle;

  /// No description provided for @welcomeWhatNotBody.
  ///
  /// In es, this message translates to:
  /// **'SentIA no es un psicólogo ni un servicio de emergencias, no hace diagnósticos y no sustituye la atención de un profesional. Las respuestas las genera una IA y pueden contener errores.'**
  String get welcomeWhatNotBody;

  /// No description provided for @welcomeHelpTitle.
  ///
  /// In es, this message translates to:
  /// **'Ayuda cuando la necesites'**
  String get welcomeHelpTitle;

  /// No description provided for @welcomeHelpBody.
  ///
  /// In es, this message translates to:
  /// **'Si en algún momento estás en peligro o en crisis, toca el escudo en la parte superior para ver líneas de ayuda que puedes llamar de inmediato.'**
  String get welcomeHelpBody;

  /// No description provided for @welcomeCreateAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get welcomeCreateAccount;

  /// No description provided for @welcomeHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'Ya tengo cuenta'**
  String get welcomeHaveAccount;

  /// No description provided for @authEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In es, this message translates to:
  /// **'tu@correo.com'**
  String get authEmailHint;

  /// No description provided for @authPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get authPasswordLabel;

  /// No description provided for @authShowPassword.
  ///
  /// In es, this message translates to:
  /// **'Mostrar contraseña'**
  String get authShowPassword;

  /// No description provided for @authHidePassword.
  ///
  /// In es, this message translates to:
  /// **'Ocultar contraseña'**
  String get authHidePassword;

  /// No description provided for @authForgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get authForgotPassword;

  /// No description provided for @authLoginButton.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get authLoginButton;

  /// No description provided for @authNoAccount.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes una cuenta?'**
  String get authNoAccount;

  /// No description provided for @authCreateAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get authCreateAccount;

  /// No description provided for @authHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes una cuenta?'**
  String get authHaveAccount;

  /// No description provided for @authLoginLink.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get authLoginLink;

  /// No description provided for @signupTitle.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Solo te pedimos lo necesario.'**
  String get signupSubtitle;

  /// No description provided for @signupPasswordHelp.
  ///
  /// In es, this message translates to:
  /// **'Usa al menos 12 caracteres. Una frase que recuerdes funciona bien.'**
  String get signupPasswordHelp;

  /// No description provided for @signupConfirmPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Repite la contraseña'**
  String get signupConfirmPasswordLabel;

  /// No description provided for @signupBirthYearLabel.
  ///
  /// In es, this message translates to:
  /// **'Año de nacimiento'**
  String get signupBirthYearLabel;

  /// No description provided for @signupAgeConfirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmo que tengo 18 años o más'**
  String get signupAgeConfirm;

  /// No description provided for @signupButton.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get signupButton;

  /// No description provided for @forgotTitle.
  ///
  /// In es, this message translates to:
  /// **'Recupera tu acceso'**
  String get forgotTitle;

  /// No description provided for @forgotBody.
  ///
  /// In es, this message translates to:
  /// **'Escribe tu correo y te enviaremos un enlace para crear una nueva contraseña.'**
  String get forgotBody;

  /// No description provided for @forgotButton.
  ///
  /// In es, this message translates to:
  /// **'Enviar enlace'**
  String get forgotButton;

  /// No description provided for @forgotSentTitle.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu correo'**
  String get forgotSentTitle;

  /// No description provided for @forgotSentBody.
  ///
  /// In es, this message translates to:
  /// **'Si existe una cuenta con ese correo, te enviamos un enlace. Vence en 30 minutos.'**
  String get forgotSentBody;

  /// No description provided for @forgotBackToLogin.
  ///
  /// In es, this message translates to:
  /// **'Volver a iniciar sesión'**
  String get forgotBackToLogin;

  /// No description provided for @validationEmail.
  ///
  /// In es, this message translates to:
  /// **'Escribe un correo válido'**
  String get validationEmail;

  /// No description provided for @validationPasswordLength.
  ///
  /// In es, this message translates to:
  /// **'Debe tener al menos 12 caracteres'**
  String get validationPasswordLength;

  /// No description provided for @validationRequired.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get validationRequired;

  /// No description provided for @validationPasswordsDiffer.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get validationPasswordsDiffer;

  /// No description provided for @validationBirthYear.
  ///
  /// In es, this message translates to:
  /// **'Escribe un año válido'**
  String get validationBirthYear;

  /// No description provided for @validationAgeConfirm.
  ///
  /// In es, this message translates to:
  /// **'Debes confirmar que eres mayor de edad'**
  String get validationAgeConfirm;

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In es, this message translates to:
  /// **'Correo o contraseña incorrectos.'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorEmailTaken.
  ///
  /// In es, this message translates to:
  /// **'Ya existe una cuenta con ese correo.'**
  String get authErrorEmailTaken;

  /// No description provided for @authErrorUnderage.
  ///
  /// In es, this message translates to:
  /// **'SentIA es solo para personas de 18 años o más.'**
  String get authErrorUnderage;

  /// No description provided for @authErrorLocked.
  ///
  /// In es, this message translates to:
  /// **'Demasiados intentos. Espera unos minutos e inténtalo de nuevo.'**
  String get authErrorLocked;

  /// No description provided for @authErrorValidation.
  ///
  /// In es, this message translates to:
  /// **'Revisa los datos e inténtalo de nuevo.'**
  String get authErrorValidation;

  /// No description provided for @consentTitle.
  ///
  /// In es, this message translates to:
  /// **'Antes de empezar'**
  String get consentTitle;

  /// No description provided for @consentSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Lee y acepta cómo cuidamos tu información. Puedes revisar o retirar tu consentimiento en Ajustes.'**
  String get consentSubtitle;

  /// No description provided for @consentDraftBanner.
  ///
  /// In es, this message translates to:
  /// **'BORRADOR — pendiente de revisión legal. Estos textos cambiarán antes del lanzamiento.'**
  String get consentDraftBanner;

  /// No description provided for @consentRequired.
  ///
  /// In es, this message translates to:
  /// **'Obligatorio'**
  String get consentRequired;

  /// No description provided for @consentOptional.
  ///
  /// In es, this message translates to:
  /// **'Opcional'**
  String get consentOptional;

  /// No description provided for @consentAcceptRequired.
  ///
  /// In es, this message translates to:
  /// **'Acepto'**
  String get consentAcceptRequired;

  /// No description provided for @consentAcceptOptional.
  ///
  /// In es, this message translates to:
  /// **'Sí, autorizo'**
  String get consentAcceptOptional;

  /// No description provided for @consentReadDocument.
  ///
  /// In es, this message translates to:
  /// **'Leer documento completo'**
  String get consentReadDocument;

  /// No description provided for @consentVersion.
  ///
  /// In es, this message translates to:
  /// **'Versión {version}'**
  String consentVersion(String version);

  /// No description provided for @consentAcceptButton.
  ///
  /// In es, this message translates to:
  /// **'Aceptar y continuar'**
  String get consentAcceptButton;

  /// No description provided for @consentSignOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get consentSignOut;

  /// No description provided for @helpTitle.
  ///
  /// In es, this message translates to:
  /// **'Ayuda inmediata'**
  String get helpTitle;

  /// No description provided for @helpCrisisButton.
  ///
  /// In es, this message translates to:
  /// **'Ayuda inmediata'**
  String get helpCrisisButton;

  /// No description provided for @helpIntro.
  ///
  /// In es, this message translates to:
  /// **'Si estás en peligro o piensas en hacerte daño, no estás solo. Llama ahora a alguno de estos servicios.'**
  String get helpIntro;

  /// No description provided for @helpCall.
  ///
  /// In es, this message translates to:
  /// **'Llamar al {phone}'**
  String helpCall(String phone);

  /// No description provided for @helpHours.
  ///
  /// In es, this message translates to:
  /// **'Horario: {hours}'**
  String helpHours(String hours);

  /// No description provided for @helpVerified.
  ///
  /// In es, this message translates to:
  /// **'Verificado en fuente oficial el {date}'**
  String helpVerified(String date);

  /// No description provided for @helpOpenSource.
  ///
  /// In es, this message translates to:
  /// **'Ver fuente oficial'**
  String get helpOpenSource;

  /// No description provided for @helpPendingClinical.
  ///
  /// In es, this message translates to:
  /// **'Pendiente de validación clínica (visible solo fuera de producción)'**
  String get helpPendingClinical;

  /// No description provided for @helpOfflineNote.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión: mostramos la lista guardada en tu teléfono.'**
  String get helpOfflineNote;

  /// No description provided for @helpCallFailed.
  ///
  /// In es, this message translates to:
  /// **'No pudimos abrir el marcador. Marca el número manualmente.'**
  String get helpCallFailed;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @profileDisplayNameLabel.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo quieres que te llamemos?'**
  String get profileDisplayNameLabel;

  /// No description provided for @profileEmergencyTitle.
  ///
  /// In es, this message translates to:
  /// **'Contacto de emergencia (opcional)'**
  String get profileEmergencyTitle;

  /// No description provided for @profileEmergencyBody.
  ///
  /// In es, this message translates to:
  /// **'Alguien de confianza. Antes de registrarlo, avísale que lo harás. Se guarda cifrado.'**
  String get profileEmergencyBody;

  /// No description provided for @profileEmergencyName.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get profileEmergencyName;

  /// No description provided for @profileEmergencyPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get profileEmergencyPhone;

  /// No description provided for @profileEmergencyRemove.
  ///
  /// In es, this message translates to:
  /// **'Quitar contacto'**
  String get profileEmergencyRemove;

  /// No description provided for @profileSaved.
  ///
  /// In es, this message translates to:
  /// **'Cambios guardados'**
  String get profileSaved;

  /// No description provided for @profileSettings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes y privacidad'**
  String get profileSettings;

  /// No description provided for @validationPhone.
  ///
  /// In es, this message translates to:
  /// **'Escribe un teléfono válido'**
  String get validationPhone;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get settingsAppearance;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get settingsThemeDark;

  /// No description provided for @settingsTextSize.
  ///
  /// In es, this message translates to:
  /// **'Tamaño del texto'**
  String get settingsTextSize;

  /// No description provided for @settingsLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageValue.
  ///
  /// In es, this message translates to:
  /// **'Español (México)'**
  String get settingsLanguageValue;

  /// No description provided for @settingsPrivacy.
  ///
  /// In es, this message translates to:
  /// **'Privacidad y consentimientos'**
  String get settingsPrivacy;

  /// No description provided for @settingsConsentGranted.
  ///
  /// In es, this message translates to:
  /// **'Aceptado'**
  String get settingsConsentGranted;

  /// No description provided for @settingsConsentNotGranted.
  ///
  /// In es, this message translates to:
  /// **'No aceptado'**
  String get settingsConsentNotGranted;

  /// No description provided for @settingsRevokeTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Retirar este consentimiento?'**
  String get settingsRevokeTitle;

  /// No description provided for @settingsRevokeRequiredBody.
  ///
  /// In es, this message translates to:
  /// **'Este consentimiento es necesario para usar SentIA. Si lo retiras, tendrás que aceptarlo de nuevo para continuar, o puedes eliminar tu cuenta.'**
  String get settingsRevokeRequiredBody;

  /// No description provided for @settingsRevokeOptionalBody.
  ///
  /// In es, this message translates to:
  /// **'Dejaremos de usar tus datos para este fin.'**
  String get settingsRevokeOptionalBody;

  /// No description provided for @settingsRevoke.
  ///
  /// In es, this message translates to:
  /// **'Retirar'**
  String get settingsRevoke;

  /// No description provided for @settingsData.
  ///
  /// In es, this message translates to:
  /// **'Tus datos'**
  String get settingsData;

  /// No description provided for @settingsExport.
  ///
  /// In es, this message translates to:
  /// **'Exportar mis datos'**
  String get settingsExport;

  /// No description provided for @settingsExportBody.
  ///
  /// In es, this message translates to:
  /// **'Descarga una copia de todo lo que guardamos sobre ti (formato JSON).'**
  String get settingsExportBody;

  /// No description provided for @settingsExportShareText.
  ///
  /// In es, this message translates to:
  /// **'Mis datos de SentIA'**
  String get settingsExportShareText;

  /// No description provided for @settingsSession.
  ///
  /// In es, this message translates to:
  /// **'Sesión'**
  String get settingsSession;

  /// No description provided for @settingsLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutAll.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión en todos los dispositivos'**
  String get settingsLogoutAll;

  /// No description provided for @settingsLogoutAllDone.
  ///
  /// In es, this message translates to:
  /// **'Cerramos tu sesión en todos los dispositivos.'**
  String get settingsLogoutAllDone;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In es, this message translates to:
  /// **'Eliminar cuenta'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar tu cuenta?'**
  String get settingsDeleteTitle;

  /// No description provided for @settingsDeleteBody.
  ///
  /// In es, this message translates to:
  /// **'Se borrarán tu perfil, tus conversaciones y tus registros. Esta acción no se puede deshacer. Solo conservaremos, sin datos de contacto, la evidencia de tus consentimientos y la bitácora de seguridad que exige la ley.'**
  String get settingsDeleteBody;

  /// No description provided for @settingsDeletePassword.
  ///
  /// In es, this message translates to:
  /// **'Escribe tu contraseña para confirmar'**
  String get settingsDeletePassword;

  /// No description provided for @settingsDeleteConfirm.
  ///
  /// In es, this message translates to:
  /// **'Eliminar definitivamente'**
  String get settingsDeleteConfirm;

  /// No description provided for @settingsServerStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado del servidor'**
  String get settingsServerStatus;

  /// No description provided for @settingsLegalVersion.
  ///
  /// In es, this message translates to:
  /// **'Documentos legales: versión {version}'**
  String settingsLegalVersion(String version);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
