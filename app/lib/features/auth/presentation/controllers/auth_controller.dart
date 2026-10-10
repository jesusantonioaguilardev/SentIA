import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:sentia2/features/auth/domain/entities/auth_user.dart';
import 'package:sentia2/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:sentia2/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:sentia2/features/auth/domain/usecases/signup_with_email_usecase.dart';

part 'auth_controller.g.dart';

sealed class AuthState {
  const new();
}

final class AuthLoading extends AuthState {
  const new();
}

final class Authenticated extends AuthState {
  const new(this.user);
  final AuthUser user;
}

final class Unauthenticated extends AuthState {
  const new();
}

final class AuthError extends AuthState {
  const new(this.message);
  final String message;
}

// TODO(etapa-1): reemplazar por auth real contra el backend (docs/05) con
// AsyncNotifier y Result<T, Failure>; hoy usa MockAuthRepository.
@riverpod
class Auth extends _$Auth {
  late LoginWithEmailUseCase _loginUseCase;
  late SignupWithEmailUseCase _signupUseCase;
  late ResetPasswordUseCase _resetPasswordUseCase;

  @override
  AuthState build() {
    final repository = ref.watch(authRepositoryProvider);
    _loginUseCase = LoginWithEmailUseCase(repository);
    _signupUseCase = SignupWithEmailUseCase(repository);
    _resetPasswordUseCase = ResetPasswordUseCase(repository);
    return const Unauthenticated();
  }

  Future<void> login(String email, String password) => _run(
    () async => Authenticated(await _loginUseCase.execute(email, password)),
  );

  Future<void> signUp(String email, String password) => _run(
    () async => Authenticated(await _signupUseCase.execute(email, password)),
  );

  Future<void> resetPassword(String email) => _run(() async {
    await _resetPasswordUseCase.execute(email);
    return const Unauthenticated();
  });

  void logout() => state = const Unauthenticated();

  void dismissError() {
    if (state is AuthError) state = const Unauthenticated();
  }

  Future<void> _run(Future<AuthState> Function() action) async {
    state = const AuthLoading();
    try {
      final next = await action();
      if (ref.mounted) state = next;
    } on Exception catch (e) {
      if (ref.mounted) state = AuthError(e.toString());
    }
  }
}
