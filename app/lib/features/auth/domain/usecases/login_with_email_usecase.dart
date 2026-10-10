import 'package:sentia2/features/auth/domain/entities/auth_user.dart';
import 'package:sentia2/features/auth/domain/repositories/auth_repository.dart';

class LoginWithEmailUseCase {
  new(this.repository);
  final AuthRepository repository;

  Future<AuthUser> execute(String email, String password) async {
    // Aquí se podrían agregar validaciones de negocio adicionales
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Por favor, ingresa un correo electrónico válido.');
    }
    if (password.isEmpty) {
      throw Exception('La contraseña no puede estar vacía.');
    }

    return await repository.signInWithEmail(email, password);
  }
}
