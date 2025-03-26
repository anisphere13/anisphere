import 'dart:io';
import 'package:flutter/foundation.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    debugPrint('❌ Merci de fournir un nom de module :');
    debugPrint('   Exemple : dart run scripts/generate_test_module.dart sante');
    exit(1);
  }

  final moduleName = args[0].toLowerCase();
  final basePath = 'test/$moduleName';
  final types = ['unit', 'widget', 'integration'];

  final templates = {
    'unit': '''import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${moduleName.toUpperCase()} - Test unitaire', () {
    test('Addition simple', () {
      expect(1 + 1, equals(2));
    });
  });
}
''',
    'widget': '''import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('${moduleName.toUpperCase()} - Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('${moduleName.toUpperCase()} Widget')),
    ));

    expect(find.text('${moduleName.toUpperCase()} Widget'), findsOneWidget);
  });
}
''',
    'integration': '''import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('${moduleName.toUpperCase()} - Test d’intégration', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('${moduleName.toUpperCase()} Integration')),
    ));

    expect(find.text('${moduleName.toUpperCase()} Integration'), findsOneWidget);
  });
}
'''
  };

  for (final type in types) {
    final dir = Directory('$basePath/$type');
    dir.createSync(recursive: true);
const String typeTest = 'widget'; // ✅ camelCase recommandé

    final file = File('$basePath/$type/${moduleName}_$type_test.dart');
    file.writeAsStringSync(templates[type]!);
    debugPrint('✅ Fichier créé : ${file.path}');
  }

  debugPrint('\n🎉 Le module "$moduleName" est prêt dans test/$moduleName');
}
