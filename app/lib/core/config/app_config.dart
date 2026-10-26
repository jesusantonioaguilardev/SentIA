import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Entorno con el que se compiló la app (`main_<flavor>.dart`).
enum Flavor { dev, staging, prod }

/// Configuración que depende del flavor.
@immutable
class AppConfig {
  const new({required this.flavor, required this.apiBaseUrl});

  /// Configuración por defecto de cada flavor. `API_BASE_URL` se puede
  /// sobreescribir con `--dart-define=API_BASE_URL=...`.
  factory forFlavor(Flavor flavor) {
    const override = String.fromEnvironment('API_BASE_URL');
    return AppConfig(
      flavor: flavor,
      apiBaseUrl: override.isNotEmpty ? override : _defaultBaseUrls[flavor]!,
    );
  }

  // dev: 10.0.2.2 es el localhost de la máquina vista desde el emulador de
  // Android. En dispositivo físico o iOS usa --dart-define=API_BASE_URL.
  // TODO(etapa-0): URLs reales de staging/prod al decidir hosting (docs/12).
  static const Map<Flavor, String> _defaultBaseUrls = {
    Flavor.dev: 'http://10.0.2.2:3000',
    Flavor.staging: 'https://api.staging.sentia.invalid',
    Flavor.prod: 'https://api.sentia.invalid',
  };

  /// Versión de la app; debe coincidir con `version` de pubspec.yaml (hay un
  /// test que lo verifica). Se registra con cada consentimiento (docs/09).
  static const appVersion = '0.1.0+1';

  final Flavor flavor;
  final String apiBaseUrl;
}

/// Se sobreescribe en `bootstrap` con la configuración del flavor.
final appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError('appConfigProvider sin inicializar'),
);
