/// Paths de la app. Usa estas constantes en vez de escribir rutas a mano.
/// La tabla de rutas y los redirects viven en `app/router.dart`.
abstract final class Routes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const signup = '/login/signup';
  static const forgotPassword = '/login/forgot-password';
  static const consent = '/consent';
  static const help = '/help';
  static const home = '/home';
  static const chat = '/chat';
  static const history = '/history';
  static const profile = '/profile';
  static const settings = '/profile/settings';
  static const status = '/status';

  /// Accesibles sin sesión.
  static const Set<String> public = {
    splash,
    welcome,
    login,
    signup,
    forgotPassword,
    help,
    status,
  };
}
