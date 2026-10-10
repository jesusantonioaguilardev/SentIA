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
  String get navHome => 'Inicio';

  @override
  String get navChat => 'Chat';

  @override
  String get navHistory => 'Historial';

  @override
  String get navProfile => 'Perfil';

  @override
  String get profileComingSoon => 'Tu perfil estará disponible pronto.';

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
}
