import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('TEST_MODULE_MODELE - Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('TEST_MODULE_MODELE Widget')),
    ));

    expect(find.text('TEST_MODULE_MODELE Widget'), findsOneWidget);
  });
}
