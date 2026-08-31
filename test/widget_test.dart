import 'package:flutter_test/flutter_test.dart';

import 'package:sentia/app/app.dart';

void main() {
  testWidgets('renders the home screen with the app title', (tester) async {
    await tester.pumpWidget(const SentiaApp());

    expect(find.text('Sentia'), findsNWidgets(2));
    expect(find.text('Tu espacio de calma y acompañamiento'), findsOneWidget);
  });
}
