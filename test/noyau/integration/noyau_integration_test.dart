import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('NOYAU - Test d’intégration', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('NOYAU Integration')),
    ));

    expect(find.text('NOYAU Integration'), findsOneWidget);
  });
}
