import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('GLOBAL - Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('GLOBAL Widget')),
    ));

    expect(find.text('GLOBAL Widget'), findsOneWidget);
  });
}
