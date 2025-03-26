import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('GLOBAL - Test d’intégration', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('GLOBAL Integration')),
    ));

    expect(find.text('GLOBAL Integration'), findsOneWidget);
  });
}
