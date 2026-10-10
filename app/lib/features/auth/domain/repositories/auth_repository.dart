import 'package:sentia2/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  /// Emite el usuario actual cuando cambia la sesión.
  Stream<AuthUser?> get onAuthStateChanged;

  /// Inicia sesión con correo y contraseña.
  Future<AuthUser> signInWithEmail(String email, String password);

  /// Crea una cuenta con correo y contraseña.
  Future<AuthUser> signUpWithEmail(String email, String password);

  /// Inicia sesión con Google (si se habilita).
  Future<AuthUser> signInWithGoogle();

  /// Envía el correo de recuperación de contraseña.
  Future<void> sendPasswordResetEmail(String email);

  /// Cierra la sesión.
  Future<void> signOut();
}
