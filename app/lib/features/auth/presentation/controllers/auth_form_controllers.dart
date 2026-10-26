import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/features/auth/data/api_auth_repository.dart';

part 'auth_form_controllers.g.dart';

/// Estado de un envío de formulario: inactivo, enviando, error (Failure).
/// Si sale bien, la sesión cambia sola y el router navega.
extension on Result<void> {
  AsyncValue<void> toAsync() => switch (this) {
    Ok() => const AsyncData(null),
    Err(:final failure) => AsyncError(failure, StackTrace.current),
  };
}

@riverpod
class LoginForm extends _$LoginForm {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> submit({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    if (ref.mounted) state = result.toAsync();
    return result is Ok;
  }
}

@riverpod
class SignupForm extends _$SignupForm {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> submit({
    required String email,
    required String password,
    required int birthYear,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(authRepositoryProvider)
        .register(email: email, password: password, birthYear: birthYear);
    if (ref.mounted) state = result.toAsync();
    return result is Ok;
  }
}

@riverpod
class ForgotPasswordForm extends _$ForgotPasswordForm {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> submit(String email) async {
    state = const AsyncLoading();
    final result = await ref
        .read(authRepositoryProvider)
        .requestPasswordReset(email);
    if (ref.mounted) state = result.toAsync();
    return result is Ok;
  }
}
