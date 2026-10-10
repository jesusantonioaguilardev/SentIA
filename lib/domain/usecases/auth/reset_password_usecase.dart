import 'package:sentia2/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> execute(String email) async {
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Por favor, ingresa un correo electrónico válido para recuperar tu contraseña.');
    }
    return await repository.sendPasswordResetEmail(email);
  }
}
