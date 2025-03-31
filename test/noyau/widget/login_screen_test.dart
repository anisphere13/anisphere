import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('login_screen.dart - Widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('Connexion')), // à remplacer
    ));

    expect(find.text('Connexion'), findsOneWidget);
  });
}
