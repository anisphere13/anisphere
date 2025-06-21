import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('renders french title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Text('Maison', textDirection: TextDirection.ltr),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Maison'), findsOneWidget);
  });
}
