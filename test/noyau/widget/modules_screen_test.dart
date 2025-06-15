import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anisphere/modules/noyau/screens/modules_screen.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('shows categories with horizontal module lists', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ModulesScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Bien-être'), findsOneWidget);
    expect(find.text('Apprentissage'), findsOneWidget);

    final listViews = tester.widgetList<ListView>(find.byType(ListView));
    expect(listViews.any((lv) => lv.scrollDirection == Axis.horizontal), isTrue);
  });
}
