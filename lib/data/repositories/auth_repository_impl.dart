import 'package:sentia2/domain/entities/auth_user.dart';
import 'package:sentia2/domain/entities/user_consent.dart';
import 'package:sentia2/domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Stream<AuthUser?> get onAuthStateChanged => Stream.value(null);

  @override
  Future<AuthUser> signInWithEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'error@test.com') {
      throw Exception('Error de autenticación simulado.');
    }
    return AuthUser(id: '123', email: email, hasConsented: false);
  }

  @override
  Future<AuthUser> signUpWithEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return AuthUser(id: '123', email: email, hasConsented: false);
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    return const AuthUser(id: 'Google_123', email: 'google@test.com', hasConsented: false);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> saveConsent(UserConsent consent) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<bool> checkConsentStatus(String userId) async {
    return false;
  }
}
