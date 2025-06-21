import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/genealogy_model.dart';
import 'package:anisphere/modules/identite/widgets/genealogy_summary_card.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('GenealogySummaryCard displays parent ids', (WidgetTester tester) async {
    final model = GenealogyModel(animalId: 'a1', fatherName: 'f1', motherName: 'm1', originCountry: 'FR');
    await tester.pumpWidget(MaterialApp(
      home: GenealogySummaryCard(genealogy: model),
    ));

    await tester.pump();

    expect(find.text('Généalogie'), findsOneWidget);
    expect(find.textContaining('Père: f1'), findsOneWidget);
    expect(find.textContaining('Mère: m1'), findsOneWidget);
    expect(find.textContaining('Origin'), findsOneWidget);
  });
}
