import 'package:sentia2/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  new(this.repository);
  final AuthRepository repository;

  Future<void> execute(String email) async {
    if (email.isEmpty || !email.contains('@')) {
      throw Exception(
        'Por favor, ingresa un correo electrónico válido para recuperar tu '
        'contraseña.',
      );
    }
    return await repository.sendPasswordResetEmail(email);
  }
}
