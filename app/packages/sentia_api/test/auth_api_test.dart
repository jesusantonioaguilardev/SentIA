import 'package:test/test.dart';
import 'package:sentia_api/sentia_api.dart';


/// tests for AuthApi
void main() {
  final instance = SentiaApi().getAuthApi();

  group(AuthApi, () {
    //Future authForgotPassword(ForgotPasswordDto forgotPasswordDto) async
    test('test authForgotPassword', () async {
      // TODO
    });

    //Future<TokenPairDto> authLogin(LoginDto loginDto) async
    test('test authLogin', () async {
      // TODO
    });

    //Future authLogout(RefreshDto refreshDto) async
    test('test authLogout', () async {
      // TODO
    });

    //Future authLogoutAll() async
    test('test authLogoutAll', () async {
      // TODO
    });

    //Future<TokenPairDto> authRefresh(RefreshDto refreshDto) async
    test('test authRefresh', () async {
      // TODO
    });

    //Future<TokenPairDto> authRegister(RegisterDto registerDto) async
    test('test authRegister', () async {
      // TODO
    });

    //Future authResetPassword(ResetPasswordDto resetPasswordDto) async
    test('test authResetPassword', () async {
      // TODO
    });

  });
}
