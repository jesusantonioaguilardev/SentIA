import 'package:sentia2/core/error/failure.dart';

/// Resultado de una operación que puede fallar. Los repositorios devuelven
/// `Result` en vez de lanzar excepciones (docs/04).
sealed class Result<T> {
  const new();

  /// Ejecuta [action] y convierte cualquier excepción en [Err].
  static Future<Result<T>> guard<T>(Future<T> Function() action) async {
    try {
      return Ok(await action());
    } on Object catch (error) {
      return Err(Failure.from(error));
    }
  }
}

/// Operación exitosa con [value].
final class Ok<T> extends Result<T> {
  const new(this.value);

  /// Valor producido.
  final T value;
}

/// Operación fallida con [failure].
final class Err<T> extends Result<T> {
  const new(this.failure);

  /// Motivo del fallo.
  final Failure failure;
}
