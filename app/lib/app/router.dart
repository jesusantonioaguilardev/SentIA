import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sentia2/app/session/session_controller.dart';
import 'package:sentia2/app/settings/settings_screen.dart';
import 'package:sentia2/app/shell/main_shell.dart';
import 'package:sentia2/core/preferences/app_preferences.dart';
import 'package:sentia2/core/routing/routes.dart';
import 'package:sentia2/features/auth/data/api_auth_repository.dart';
import 'package:sentia2/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:sentia2/features/auth/presentation/screens/login_screen.dart';
import 'package:sentia2/features/auth/presentation/screens/signup_screen.dart';
import 'package:sentia2/features/chat/presentation/screens/chat_screen.dart';
import 'package:sentia2/features/consent/presentation/screens/consent_screen.dart';
import 'package:sentia2/features/home/presentation/screens/home_screen.dart';
import 'package:sentia2/features/mood/presentation/screens/mood_screen.dart';
import 'package:sentia2/features/onboarding/presentation/welcome_screen.dart';
import 'package:sentia2/features/profile/presentation/profile_screen.dart';
import 'package:sentia2/features/safety/presentation/help_screen.dart';
import 'package:sentia2/features/status/presentation/screens/status_screen.dart';
import 'package:sentia2/shared/widgets/sentia_logo.dart';

/// Decide a dónde ir según la sesión (docs/04 §router):
/// sin sesión → bienvenida/login; sin consentimiento → consentimiento;
/// lista → app. La ayuda inmediata es accesible siempre.
String? sessionRedirect({
  required AsyncValue<SessionStatus> session,
  required String location,
  required bool welcomeSeen,
}) {
  if (location == Routes.help) return null;
  final status = session.value;
  if (status == null) {
    return location == Routes.splash ? null : Routes.splash;
  }
  return switch (status) {
    SessionStatus.signedOut =>
      Routes.public.contains(location) && location != Routes.splash
          ? null
          : (welcomeSeen ? Routes.login : Routes.welcome),
    SessionStatus.needsConsent =>
      location == Routes.consent ? null : Routes.consent,
    SessionStatus.ready =>
      location == Routes.status ||
              !Routes.public.contains(location) && location != Routes.consent
          ? null
          : Routes.home,
  };
}

final routerProvider = Provider<GoRouter>((ref) {
  // go_router reevalúa los redirects cuando cambia la sesión.
  final refresh = ValueNotifier<int>(0);
  ref
    ..listen(sessionProvider, (_, _) => refresh.value++)
    ..listen(
      appPreferencesProvider.select((p) => p.welcomeSeen),
      (_, _) => refresh.value++,
    );

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) => sessionRedirect(
      session: ref.read(sessionProvider),
      location: state.matchedLocation,
      welcomeSeen: ref.read(appPreferencesProvider).welcomeSeen,
    ),
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const _Splash()),
      GoRoute(
        path: Routes.welcome,
        builder: (context, _) {
          void leave(String to) {
            unawaited(
              ref.read(appPreferencesProvider.notifier).markWelcomeSeen(),
            );
            context.go(to);
          }

          return WelcomeScreen(
            onCreateAccount: () => leave(Routes.signup),
            onLogin: () => leave(Routes.login),
          );
        },
      ),
      GoRoute(
        path: Routes.login,
        builder: (_, _) => const LoginScreen(),
        routes: [
          GoRoute(path: 'signup', builder: (_, _) => const SignupScreen()),
          GoRoute(
            path: 'forgot-password',
            builder: (_, _) => const ForgotPasswordScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.consent,
        builder: (_, _) => ConsentScreen(
          onCompleted: () =>
              ref.read(sessionProvider.notifier).refreshConsent(),
          onSignOut: () => ref.read(authRepositoryProvider).logout(),
        ),
      ),
      GoRoute(path: Routes.help, builder: (_, _) => const HelpScreen()),
      GoRoute(path: Routes.status, builder: (_, _) => const StatusScreen()),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: Routes.home, builder: (_, _) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: Routes.chat, builder: (_, _) => const ChatScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.history,
                builder: (_, _) => const MoodScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (_, _) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'settings',
                    builder: (_, _) => const SettingsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});

class _Splash extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: SentiaLogo(size: 96)));
}
