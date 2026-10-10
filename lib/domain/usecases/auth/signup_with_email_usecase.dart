import 'package:sentia2/domain/entities/auth_user.dart';
import 'package:sentia2/domain/repositories/auth_repository.dart';

class SignupWithEmailUseCase {
  final AuthRepository repository;

  SignupWithEmailUseCase(this.repository);

  Future<AuthUser> execute(String email, String password) async {
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Por favor, ingresa un correo electrónico válido.');
    }
    if (password.length < 8) {
      throw Exception('La contraseña debe tener al menos 8 caracteres para mayor seguridad.');
    }
    
    return await repository.signUpWithEmail(email, password);
  }
}
