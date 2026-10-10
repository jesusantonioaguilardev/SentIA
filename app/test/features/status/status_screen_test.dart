import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/features/status/data/api_status_repository.dart';
import 'package:sentia2/features/status/domain/server_status.dart';
import 'package:sentia2/features/status/presentation/screens/status_screen.dart';

import '../../helpers/pump_app.dart';

class _FakeStatusRepository implements StatusRepository {
  new(this.result);

  final Result<ServerStatus> result;

  @override
  Future<Result<ServerStatus>> check() async => result;
}

void main() {
  const healthy = ServerStatus(
    databaseUp: true,
    environment: 'dev',
    version: '0.0.1',
  );

  Future<void> pumpStatus(
    WidgetTester tester,
    Result<ServerStatus> result, {
    Size size = TestSizes.phone,
  }) async {
    await tester.pumpApp(
      const StatusScreen(),
      size: size,
      overrides: [
        statusRepositoryProvider.overrideWithValue(
          _FakeStatusRepository(result),
        ),
      ],
    );
    await tester.pumpAndSettle();
  }

  testWidgets('saluda y muestra el servidor disponible', (tester) async {
    await pumpStatus(tester, const Ok(healthy));

    expect(find.text('Hola, soy SentIA'), findsOneWidget);
    expect(find.text('Entorno: dev'), findsOneWidget);
    expect(find.text('Servidor disponible'), findsOneWidget);
  });

  testWidgets('avisa si la base de datos no está disponible', (tester) async {
    await pumpStatus(
      tester,
      const Ok(
        ServerStatus(databaseUp: false, environment: 'dev', version: '0.0.1'),
      ),
    );

    expect(
      find.text(
        'El servidor responde, pero la base de datos no está disponible',
      ),
      findsOneWidget,
    );
  });

  testWidgets('muestra un mensaje amable sin conexión', (tester) async {
    await pumpStatus(tester, const Err(NetworkFailure()));

    expect(
      find.text('No hay conexión. Revisa tu internet e inténtalo de nuevo.'),
      findsOneWidget,
    );
  });

  testWidgets('en tablet el contenido no pasa de 720 dp', (tester) async {
    await pumpStatus(tester, const Ok(healthy), size: TestSizes.tablet);

    final card = tester.getSize(find.byType(Card));
    expect(card.width, lessThanOrEqualTo(720));
    expect(tester.takeException(), isNull);
  });

  testWidgets('no se desborda con texto al 200 %', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await pumpStatus(tester, const Ok(healthy));

    expect(tester.takeException(), isNull);
  });
}
