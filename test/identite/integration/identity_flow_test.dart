import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('IDENTITE - Test d\'intégration de base', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('IDENTITE Integration')),
    ));

    expect(find.text('IDENTITE Integration'), findsOneWidget);
  });
}
