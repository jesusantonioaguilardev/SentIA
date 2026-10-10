import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/app.dart';

void main() {
  testWidgets('SentIA2 base app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame inside a ProviderScope.
    await tester.pumpWidget(
      const ProviderScope(
        child: SentIA2App(),
      ),
    );

    // Verify that onboarding screen renders successfully.
    expect(find.textContaining('SentIA'), findsAtLeastNWidgets(1));
  });
}
