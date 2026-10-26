import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/app/router.dart';
import 'package:sentia2/app/session/session_controller.dart';
import 'package:sentia2/core/routing/routes.dart';

String? go(
  String location,
  AsyncValue<SessionStatus> session, {
  bool welcomeSeen = false,
}) => sessionRedirect(
  session: session,
  location: location,
  welcomeSeen: welcomeSeen,
);

void main() {
  const signedOut = AsyncData(SessionStatus.signedOut);
  const needsConsent = AsyncData(SessionStatus.needsConsent);
  const ready = AsyncData(SessionStatus.ready);

  test('la ayuda inmediata es accesible en cualquier estado', () {
    for (final s in [
      const AsyncLoading<SessionStatus>(),
      signedOut,
      needsConsent,
      ready,
    ]) {
      expect(go(Routes.help, s), isNull);
    }
  });

  test('mientras carga la sesión muestra el splash', () {
    expect(go(Routes.home, const AsyncLoading()), Routes.splash);
    expect(go(Routes.splash, const AsyncLoading()), isNull);
  });

  test('sin sesión: bienvenida la primera vez, después login', () {
    expect(go(Routes.splash, signedOut), Routes.welcome);
    expect(go(Routes.home, signedOut, welcomeSeen: true), Routes.login);
    expect(go(Routes.signup, signedOut), isNull);
    expect(go(Routes.forgotPassword, signedOut), isNull);
  });

  test('sin consentimiento vigente: siempre a consentimiento', () {
    expect(go(Routes.home, needsConsent), Routes.consent);
    expect(go(Routes.login, needsConsent), Routes.consent);
    expect(go(Routes.consent, needsConsent), isNull);
  });

  test('lista: entra a la app y no vuelve a pantallas de cuenta', () {
    expect(go(Routes.splash, ready), Routes.home);
    expect(go(Routes.login, ready), Routes.home);
    expect(go(Routes.consent, ready), Routes.home);
    expect(go(Routes.chat, ready), isNull);
    expect(go(Routes.settings, ready), isNull);
    expect(go(Routes.status, ready), isNull);
  });
}
