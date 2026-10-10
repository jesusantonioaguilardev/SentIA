import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/features/auth/domain/entities/auth_user.dart';
import 'package:sentia2/features/auth/domain/repositories/auth_repository.dart';

part 'mock_auth_repository.g.dart';

// TODO(etapa-1): implementación real contra /v1/auth (docs/05).
@riverpod
AuthRepository authRepository(Ref ref) => MockAuthRepository();

class MockAuthRepository implements AuthRepository {
  @override
  Stream<AuthUser?> get onAuthStateChanged => Stream.value(null);

  @override
  Future<AuthUser> signInWithEmail(String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (email == 'error@test.com') {
      throw Exception('Error de autenticación simulado.');
    }
    return AuthUser(id: '123', email: email);
  }

  @override
  Future<AuthUser> signUpWithEmail(String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return AuthUser(id: '123', email: email);
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return const AuthUser(id: 'Google_123', email: 'google@test.com');
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
