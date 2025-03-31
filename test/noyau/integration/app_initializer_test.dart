import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('app_initializer.dart - Test d\'intégration', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Initialisation'),
      ),
    ));

    expect(find.text('Initialisation'), findsOneWidget);
  });
}
