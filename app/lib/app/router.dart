import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sentia2/app/shell/main_shell.dart';
import 'package:sentia2/core/routing/routes.dart';
import 'package:sentia2/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:sentia2/features/auth/presentation/screens/login_screen.dart';
import 'package:sentia2/features/auth/presentation/screens/signup_screen.dart';
import 'package:sentia2/features/chat/presentation/screens/chat_screen.dart';
import 'package:sentia2/features/home/presentation/screens/home_screen.dart';
import 'package:sentia2/features/mood/presentation/screens/mood_screen.dart';
import 'package:sentia2/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:sentia2/features/status/presentation/screens/status_screen.dart';

// TODO(etapa-1): redirects de auth y consentimiento (docs/04) cuando exista
// sesión real; hoy el onboarding no se persiste y siempre se muestra primero.
final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: Routes.onboarding,
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
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
                builder: (_, _) => const ProfilePlaceholder(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
