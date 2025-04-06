import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('NOYAU - Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('NOYAU Widget')),
    ));

    expect(find.text('NOYAU Widget'), findsOneWidget);

    // TODO: Ajouter d'autres tests de widget ici
  });
}
