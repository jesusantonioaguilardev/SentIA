import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/app/theme/app_theme.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/l10n/app_localizations.dart';

/// Tamaños de prueba de docs/04 §Responsive.
abstract final class TestSizes {
  static const phone = Size(360, 640);
  static const tablet = Size(800, 1280);
}

extension PumpApp on WidgetTester {
  /// Monta [widget] con tema, localización y Riverpod, en un tamaño dado.
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
    Size size = TestSizes.phone,
    Flavor flavor = Flavor.dev,
  }) async {
    view.physicalSize = size;
    view.devicePixelRatio = 1;
    addTearDown(view.reset);

    await pumpWidget(
      ProviderScope(
        // Sin reintentos automáticos de Riverpod 3: los tests deben ser
        // deterministas y no dejar timers pendientes.
        retry: (_, _) => null,
        overrides: [
          appConfigProvider.overrideWithValue(AppConfig.forFlavor(flavor)),
          ...overrides,
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
