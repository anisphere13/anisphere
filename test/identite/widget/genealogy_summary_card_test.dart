import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/genealogy_model.dart';
import 'package:anisphere/modules/identite/widgets/genealogy_summary_card.dart';
import 'package:anisphere/l10n/app_localizations.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('GenealogySummaryCard displays parent ids', (WidgetTester tester) async {
    final model = GenealogyModel(animalId: 'a1', fatherId: 'f1', motherId: 'm1');
    await tester.pumpWidget(MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en'),
      home: GenealogySummaryCard(genealogy: model),
    ));

    await tester.pump();

    expect(find.text('Genealogy'), findsOneWidget);
    expect(find.textContaining('Father: f1'), findsOneWidget);
    expect(find.textContaining('Mother: m1'), findsOneWidget);
  });
}
