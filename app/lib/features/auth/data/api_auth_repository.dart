import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/core/network/api_providers.dart';
import 'package:sentia2/core/security/token_storage.dart';
import 'package:sentia2/features/auth/domain/auth_repository.dart';
import 'package:sentia_api/sentia_api.dart';

part 'api_auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) => ApiAuthRepository(
  ref.watch(sentiaApiProvider).getAuthApi(),
  ref.watch(tokenStorageProvider),
);

class ApiAuthRepository implements AuthRepository {
  new(this._api, this._tokens);

  final AuthApi _api;
  final TokenStorage _tokens;

  @override
  Future<Result<void>> register({
    required String email,
    required String password,
    required int birthYear,
  }) => Result.guard(() async {
    final response = await _api.authRegister(
      registerDto: RegisterDto(
        email: email.trim(),
        password: password,
        birthYear: birthYear,
        ageConfirmed: true,
      ),
    );
    await _save(response.data!);
  });

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) => Result.guard(() async {
    final response = await _api.authLogin(
      loginDto: LoginDto(email: email.trim(), password: password),
    );
    await _save(response.data!);
  });

  @override
  Future<Result<void>> requestPasswordReset(String email) =>
      Result.guard(() async {
        await _api.authForgotPassword(
          forgotPasswordDto: ForgotPasswordDto(email: email.trim()),
        );
      });

  @override
  Future<void> logout() async {
    final tokens = await _tokens.read();
    if (tokens != null) {
      // Se intenta revocar en el servidor, pero la sesión local se cierra
      // siempre: sin red, el refresh expira solo.
      await Result.guard(
        () => _api.authLogout(
          refreshDto: RefreshDto(refreshToken: tokens.refreshToken),
        ),
      );
    }
    await _tokens.clear();
  }

  @override
  Future<Result<void>> logoutAll() => Result.guard(() async {
    await _api.authLogoutAll();
    await _tokens.clear();
  });

  Future<void> _save(TokenPairDto pair) => _tokens.save(
    SessionTokens(
      accessToken: pair.accessToken,
      refreshToken: pair.refreshToken,
    ),
  );
}
