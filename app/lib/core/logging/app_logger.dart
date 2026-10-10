import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sentia2/core/logging/log_redactor.dart';

/// Logger de la app. Todo pasa por [LogRedactor] antes de escribirse.
///
/// En release solo se emiten advertencias y errores. Nunca pases aquí
/// contenido de chat, tests o notas (docs/11).
abstract final class AppLogger {
  static final Logger _logger = Logger(
    level: kReleaseMode ? Level.warning : Level.debug,
    printer: SimplePrinter(printTime: true),
  );

  /// Información de depuración (no se emite en release).
  static void debug(String message, [Map<String, Object?>? context]) =>
      _logger.d(_format(message, context));

  /// Evento informativo (no se emite en release).
  static void info(String message, [Map<String, Object?>? context]) =>
      _logger.i(_format(message, context));

  /// Situación anómala recuperable.
  static void warning(String message, [Map<String, Object?>? context]) =>
      _logger.w(_format(message, context));

  /// Error. [error] se registra solo por su tipo, no por su mensaje, porque
  /// los mensajes de excepción pueden contener datos del usuario.
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) => _logger.e(
    _format(message, {...?context, 'errorType': ?error?.runtimeType}),
    stackTrace: stackTrace,
  );

  static String _format(String message, Map<String, Object?>? context) {
    final safeMessage = LogRedactor.redact(message);
    if (context == null || context.isEmpty) return safeMessage;
    return '$safeMessage ${LogRedactor.redactContext(context)}';
  }
}
