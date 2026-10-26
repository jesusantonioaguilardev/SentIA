import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/features/consent/data/api_consent_repository.dart';
import 'package:sentia2/features/consent/domain/consent.dart';
import 'package:sentia2/features/consent/presentation/screens/consent_screen.dart';

import '../../helpers/pump_app.dart';

ConsentDocument doc(String id, ConsentType type, {required bool required}) =>
    ConsentDocument(
      id: id,
      type: type,
      version: '0.1-borrador',
      title: 'Documento $id',
      content: '# Título\nTexto con **negrita**.',
      required: required,
      isDraft: true,
    );

class _FakeConsents implements ConsentRepository {
  final List<ConsentDocument> docs = [
    doc('privacy', ConsentType.privacyNotice, required: true),
    doc('terms', ConsentType.terms, required: true),
    doc('research', ConsentType.research, required: false),
  ];
  final recorded = <String, bool>{};

  @override
  Future<Result<List<ConsentDocument>>> currentDocuments() async => Ok(docs);

  @override
  Future<Result<List<ConsentStatus>>> myStatus() async => Ok([
    for (final d in docs)
      ConsentStatus(document: d, granted: recorded[d.id] ?? false),
  ]);

  @override
  Future<Result<void>> record({
    required String documentId,
    required bool granted,
  }) async {
    recorded[documentId] = granted;
    return const Ok(null);
  }
}

void main() {
  testWidgets(
    'solo permite continuar con los obligatorios marcados y lo registra',
    (tester) async {
      final consents = _FakeConsents();
      var completed = false;
      await tester.pumpApp(
        ConsentScreen(onCompleted: () => completed = true, onSignOut: () {}),
        overrides: [consentRepositoryProvider.overrideWithValue(consents)],
        // Teléfono grande (412×915, docs/04) para que las tres tarjetas quepan.
        size: const Size(412, 915),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('BORRADOR'), findsOneWidget);
      FilledButton button() => tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Aceptar y continuar'),
      );
      expect(button().onPressed, isNull);

      // Ninguna casilla viene marcada (consentimiento expreso).
      final boxes = find.byType(CheckboxListTile);
      expect(
        tester
            .widgetList<CheckboxListTile>(boxes)
            .every((b) => b.value == false),
        isTrue,
      );

      Future<void> check(int index) async {
        final box = find.byType(Checkbox).at(index);
        await tester.ensureVisible(box);
        await tester.pumpAndSettle();
        await tester.tap(box);
        await tester.pump();
      }

      await check(0);
      await tester.pump();
      expect(button().onPressed, isNull);

      await check(1);
      await tester.pump();
      expect(button().onPressed, isNotNull);

      await tester.tap(find.text('Aceptar y continuar'));
      await tester.pumpAndSettle();

      expect(completed, isTrue);
      expect(consents.recorded, {
        'privacy': true,
        'terms': true,
        'research': false,
      });
    },
  );
}
