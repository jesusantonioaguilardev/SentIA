import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/app/app.dart';
import 'package:sentia2/app/theme/app_theme.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/core/logging/app_logger.dart';

/// Punto de arranque común a los tres flavors.
void bootstrap(Flavor flavor) {
  WidgetsFlutterBinding.ensureInitialized();
  AppTheme.configureFonts();

  // Errores no capturados: se registran sin su mensaje (puede contener datos
  // del usuario). TODO(etapa-2): enviar a crash reporting con PII eliminada.
  FlutterError.onError = (details) {
    AppLogger.error(
      'Error de Flutter no capturado',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (kDebugMode) FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.error(
      'Error asíncrono no capturado',
      error: error,
      stackTrace: stack,
    );
    return true;
  };

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(AppConfig.forFlavor(flavor)),
      ],
      child: const SentiaApp(),
    ),
  );
}
