import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/features/auth/data/api_auth_repository.dart';
import 'package:sentia2/features/auth/domain/auth_repository.dart';
import 'package:sentia2/features/auth/presentation/screens/login_screen.dart';

import '../../helpers/pump_app.dart';

class _FakeAuth implements AuthRepository {
  Result<void> loginResult = const Ok(null);
  ({String email, String password})? lastLogin;

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    lastLogin = (email: email, password: password);
    return loginResult;
  }

  @override
  Future<Result<void>> register({
    required String email,
    required String password,
    required int birthYear,
  }) async => const Ok(null);

  @override
  Future<Result<void>> requestPasswordReset(String email) async =>
      const Ok(null);

  @override
  Future<void> logout() async {}

  @override
  Future<Result<void>> logoutAll() async => const Ok(null);
}

void main() {
  late _FakeAuth auth;

  Future<void> pump(WidgetTester tester, {Size size = TestSizes.phone}) async {
    auth = _FakeAuth();
    await tester.pumpApp(
      const LoginScreen(),
      size: size,
      overrides: [authRepositoryProvider.overrideWithValue(auth)],
    );
  }

  testWidgets('sigue el diseño: título, insignia y sin Google', (tester) async {
    await pump(tester);

    expect(find.text('SentIA'), findsOneWidget);
    expect(find.text('Tu espacio personal y seguro'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(find.textContaining('Google'), findsNothing);
    expect(find.byTooltip('Ayuda inmediata'), findsOneWidget);
  });

  testWidgets('valida antes de enviar', (tester) async {
    await pump(tester);

    await tester.ensureVisible(find.text('Iniciar sesión'));
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pump();

    expect(find.text('Escribe un correo válido'), findsOneWidget);
    expect(auth.lastLogin, isNull);
  });

  testWidgets('muestra el error de credenciales del backend', (tester) async {
    await pump(tester);
    auth.loginResult = const Err(
      ServerFailure(statusCode: 401, code: 'INVALID_CREDENTIALS'),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'ana@correo.mx');
    await tester.enterText(find.byType(TextFormField).at(1), 'contraseña');
    await tester.ensureVisible(find.text('Iniciar sesión'));
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(auth.lastLogin?.email, 'ana@correo.mx');
    expect(find.text('Correo o contraseña incorrectos.'), findsOneWidget);
  });

  testWidgets('en tablet y con texto al 200 % no se desborda', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await pump(tester, size: TestSizes.tablet);

    expect(tester.takeException(), isNull);
  });
}
