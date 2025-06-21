import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/screens/genealogy_screen.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('GenealogyScreen shows import button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: GenealogyScreen(),
    ));
    await tester.pump();
    expect(find.text('Généalogie'), findsOneWidget);
    expect(find.text('Importer PDF'), findsOneWidget);
  });
}
