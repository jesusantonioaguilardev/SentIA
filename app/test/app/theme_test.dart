import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/app/theme/app_theme.dart';
import 'package:sentia2/app/theme/sentia_colors.dart';
import 'package:sentia2/shared/widgets/privacy_badge.dart';
import 'package:sentia2/shared/widgets/sentia_logo.dart';

import '../helpers/pump_app.dart';

/// Contraste WCAG 2.1 entre dos colores opacos.
double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

void main() {
  for (final (name, theme) in [
    ('claro', AppTheme.light),
    ('oscuro', AppTheme.dark),
  ]) {
    group('tema $name', () {
      final c = theme.colorScheme;
      final extra = theme.extension<SentiaColors>()!;

      test('texto principal sobre superficies cumple AA (4.5:1)', () {
        expect(_contrast(c.onSurface, c.surface), greaterThanOrEqualTo(4.5));
        expect(
          _contrast(c.onSurfaceVariant, c.surface),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrast(c.onSurface, c.surfaceContainerLowest),
          greaterThanOrEqualTo(4.5),
        );
      });

      test('botón primario cumple AA', () {
        final style = theme.filledButtonTheme.style!;
        final bg = style.backgroundColor!.resolve({})!;
        final fg = style.foregroundColor!.resolve({})!;
        expect(_contrast(fg, bg), greaterThanOrEqualTo(4.5));
      });

      test('incluye los colores extra del sistema de diseño', () {
        expect(extra.privacyContainer, isNotNull);
      });
    });
  }

  testWidgets('PrivacyBadge muestra su texto', (tester) async {
    await tester.pumpApp(
      const Center(child: PrivacyBadge(label: 'Tu espacio personal y seguro')),
    );

    expect(find.text('Tu espacio personal y seguro'), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
  });

  testWidgets('SentiaLogo se anuncia a lectores de pantalla', (tester) async {
    await tester.pumpApp(const Center(child: SentiaLogo()));

    expect(find.bySemanticsLabel('SentIA'), findsOneWidget);
  });
}
