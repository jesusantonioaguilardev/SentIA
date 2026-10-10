import 'package:dio/dio.dart';

/// Error de dominio. La UI lo traduce a un mensaje amable y localizado;
/// nunca muestra detalles técnicos al usuario.
sealed class Failure implements Exception {
  const new();

  /// Convierte cualquier excepción de la capa de datos en un [Failure].
  factory from(Object error) => switch (error) {
    Failure() => error,
    DioException(type: DioExceptionType.badResponse, :final response) =>
      ServerFailure(
        statusCode: response?.statusCode,
        code: _errorCode(response?.data),
      ),
    DioException(
      type: DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout ||
          DioExceptionType.connectionError,
    ) =>
      const NetworkFailure(),
    _ => const UnexpectedFailure(),
  };

  /// Lee `error.code` del formato de error de la API (docs/05).
  static String? _errorCode(Object? body) {
    if (body case {'error': {'code': final String code}}) return code;
    return null;
  }
}

/// Sin conexión o tiempo de espera agotado.
final class NetworkFailure extends Failure {
  const new();
}

/// El servidor respondió con un error.
final class ServerFailure extends Failure {
  const new({this.statusCode, this.code});

  /// Código HTTP, si lo hubo.
  final int? statusCode;

  /// Código de error de la API, p. ej. `CONSENT_REQUIRED`.
  final String? code;
}

/// Cualquier otro error no previsto.
final class UnexpectedFailure extends Failure {
  const new();
}
