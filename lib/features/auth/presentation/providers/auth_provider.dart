import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/domain/entities/auth_user.dart';
import 'package:sentia2/domain/repositories/auth_repository.dart';
import 'package:sentia2/data/providers/repository_providers.dart';
import 'package:sentia2/domain/usecases/auth/login_with_email_usecase.dart';
import 'package:sentia2/domain/usecases/auth/signup_with_email_usecase.dart';
import 'package:sentia2/domain/usecases/auth/reset_password_usecase.dart';

part 'auth_provider.freezed.dart';
part 'auth_provider.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(AuthUser user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

@riverpod
class Auth extends _$Auth {
  late final LoginWithEmailUseCase _loginUseCase;
  late final SignupWithEmailUseCase _signupUseCase;
  late final ResetPasswordUseCase _resetPasswordUseCase;

  @override
  AuthState build() {
    final repository = ref.watch(authRepositoryProvider);
    _loginUseCase = LoginWithEmailUseCase(repository);
    _signupUseCase = SignupWithEmailUseCase(repository);
    _resetPasswordUseCase = ResetPasswordUseCase(repository);

    return const AuthState.unauthenticated();
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _loginUseCase.execute(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _signupUseCase.execute(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AuthState.loading();
    try {
      await _resetPasswordUseCase.execute(email);
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void logout() {
    state = const AuthState.unauthenticated();
  }

  void dismissError() {
    state = state.maybeMap(
      error: (_) => const AuthState.unauthenticated(),
      orElse: () => state,
    );
  }
}
