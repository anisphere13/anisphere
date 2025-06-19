import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/screens/genealogy_summary_card.dart';

void main() {
  testWidgets('GenealogySummaryCard displays parent ids', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: GenealogySummaryCard(animalId: 'a1', fatherId: 'f1', motherId: 'm1'),
    ));

    expect(find.text('Genealogy of a1'), findsOneWidget);
    expect(find.textContaining('Father: f1'), findsOneWidget);
    expect(find.textContaining('Mother: m1'), findsOneWidget);
  });
}
