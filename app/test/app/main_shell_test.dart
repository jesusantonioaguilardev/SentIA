import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sentia2/app/shell/main_shell.dart';
import 'package:sentia2/app/theme/app_theme.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/rounded_bottom_nav.dart';

import '../helpers/pump_app.dart';

/// Shell con ramas vacías: prueba la navegación adaptativa sin depender de
/// las pantallas heredadas.
Future<void> _pumpShell(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: '/a',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => MainShell(shell: shell),
        branches: [
          for (final path in ['/a', '/b', '/c', '/d'])
            StatefulShellBranch(
              routes: [
                GoRoute(path: path, builder: (_, _) => Text('rama $path')),
              ],
            ),
        ],
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(AppConfig.forFlavor(Flavor.dev)),
      ],
      child: MaterialApp.router(
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('teléfono: bottom navigation', (tester) async {
    await _pumpShell(tester, TestSizes.phone);

    expect(find.byType(RoundedBottomNav), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('tablet: navigation rail', (tester) async {
    await _pumpShell(tester, TestSizes.tablet);

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(RoundedBottomNav), findsNothing);
  });

  testWidgets('cambia de pestaña al tocar un destino', (tester) async {
    await _pumpShell(tester, TestSizes.phone);

    await tester.tap(find.text('Historial'));
    await tester.pumpAndSettle();

    expect(find.text('rama /c'), findsOneWidget);
  });

  testWidgets('en la pestaña de chat oculta la barra en teléfono', (
    tester,
  ) async {
    await _pumpShell(tester, TestSizes.phone);

    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();

    expect(find.byType(RoundedBottomNav), findsNothing);
  });
}
