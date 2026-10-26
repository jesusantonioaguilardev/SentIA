import 'package:sentia2/core/error/result.dart';

/// Cuenta y sesión contra el backend (docs/05). Al iniciar sesión o
/// registrarse, los tokens quedan guardados y la sesión de la app reacciona.
abstract interface class AuthRepository {
  /// Crea la cuenta. `birthYear` es autodeclarado (solo +18, docs/12).
  Future<Result<void>> register({
    required String email,
    required String password,
    required int birthYear,
  });

  Future<Result<void>> login({required String email, required String password});

  /// Pide el enlace de restablecimiento. Responde igual exista o no la cuenta.
  Future<Result<void>> requestPasswordReset(String email);

  /// Cierra la sesión de este dispositivo. Borra los tokens aunque falle
  /// la red.
  Future<void> logout();

  /// Cierra la sesión en todos los dispositivos.
  Future<Result<void>> logoutAll();
}
