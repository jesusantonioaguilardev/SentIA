import '../entities/auth_user.dart';
import '../entities/user_consent.dart';

abstract class AuthRepository {
  /// Stream that emits the current user on auth state changes.
  Stream<AuthUser?> get onAuthStateChanged;

  /// Signs in with email and password.
  Future<AuthUser> signInWithEmail(String email, String password);

  /// Signs up with email and password.
  Future<AuthUser> signUpWithEmail(String email, String password);

  /// Signs in with Google (if supported).
  Future<AuthUser> signInWithGoogle();

  /// Sends a password reset email.
  Future<void> sendPasswordResetEmail(String email);

  /// Signs out.
  Future<void> signOut();

  /// Saves the user's consent information.
  Future<void> saveConsent(UserConsent consent);

  /// Checks if the user has already consented.
  Future<bool> checkConsentStatus(String userId);
}
