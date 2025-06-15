import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/screens/modules_by_category_screen.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';

void main() {
  testWidgets('displays categories with horizontal lists', (tester) async {
    final modules = {
      'Cat1': [
        ModuleModel(
          id: 'm1',
          name: 'Module1',
          category: 'Cat1',
          description: 'desc1',
        ),
      ],
      'Cat2': [
        ModuleModel(
          id: 'm2',
          name: 'Module2',
          category: 'Cat2',
          description: 'desc2',
        ),
      ],
    };
    await tester.pumpWidget(
      MaterialApp(
        home: ModulesByCategoryScreen(modulesByCategory: modules),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Cat1'), findsOneWidget);
    expect(find.text('Cat2'), findsOneWidget);
    // Verify horizontal list by checking ListView scroll direction
    final listViews = tester.widgetList<ListView>(find.byType(ListView));
    expect(listViews.any((lv) => lv.scrollDirection == Axis.horizontal), isTrue);
  });
}
