import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/features/safety/data/safety_repository_impl.dart';
import 'package:sentia2/features/safety/domain/safety_resource.dart';
import 'package:sentia2/features/safety/presentation/help_screen.dart';

import '../../helpers/pump_app.dart';

class _FakeSafety implements SafetyRepository {
  @override
  Future<SafetyResources> resources() async => SafetyResources(
    fromCache: true,
    items: [
      SafetyResource(
        name: 'Línea de prueba',
        description: 'Descripción',
        phone: '8001234567',
        hours: '24 horas',
        verifiedSourceUrl: 'https://www.gob.mx/prueba',
        verifiedAt: DateTime(2026, 10, 25),
        clinicallyApproved: false,
      ),
    ],
  );
}

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  testWidgets('muestra recursos con botón de llamada y su fuente', (
    tester,
  ) async {
    await tester.pumpApp(
      const HelpScreen(),
      overrides: [safetyRepositoryProvider.overrideWithValue(_FakeSafety())],
    );
    await tester.pumpAndSettle();

    expect(find.text('Ayuda inmediata'), findsOneWidget);
    expect(find.text('Línea de prueba'), findsOneWidget);
    expect(find.text('Llamar al 800 123 4567'), findsOneWidget);
    expect(find.textContaining('Verificado en fuente oficial'), findsOneWidget);
    expect(find.textContaining('Sin conexión'), findsOneWidget);
    // En dev se avisa que falta la validación clínica.
    expect(
      find.textContaining('Pendiente de validación clínica'),
      findsOneWidget,
    );
  });

  testWidgets('en prod no muestra avisos internos', (tester) async {
    await tester.pumpApp(
      const HelpScreen(),
      flavor: Flavor.prod,
      overrides: [safetyRepositoryProvider.overrideWithValue(_FakeSafety())],
    );
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Pendiente de validación clínica'),
      findsNothing,
    );
    expect(find.byIcon(Icons.call), findsOneWidget);
  });
}
