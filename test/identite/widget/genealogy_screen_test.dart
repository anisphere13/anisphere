import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/screens/genealogy_screen.dart';

void main() {
  testWidgets('GenealogyScreen shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GenealogyScreen()));
    expect(find.text('Genealogy'), findsOneWidget);
    expect(find.text('Genealogy Screen'), findsOneWidget);
  });
}
