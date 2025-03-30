import 'dart:io';
import 'package:path/path.dart' as p;

void main() {
  final libDir = Directory('lib');
  final testBase = Directory('test/global');

  if (!libDir.existsSync()) {
    print('❌ Dossier lib/ introuvable.');
    exit(1);
  }

  final types = ['unit', 'widget', 'integration'];
  final templates = {
    'unit': (String name) => '''import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$name - Test unitaire', () {
    test('Addition simple', () {
      expect(1 + 1, equals(2));
    });

    // TODO: Ajouter d'autres tests unitaires
  });
}
''',
    'widget': (String name) => '''import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('$name - Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('$name Widget')),
    ));

    expect(find.text('$name Widget'), findsOneWidget);

    // TODO: Ajouter d'autres tests de widget
  });
}
''',
    'integration': (String name) => '''import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('$name - Test d’intégration', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('$name Integration')),
    ));

    expect(find.text('$name Integration'), findsOneWidget);

    // TODO: Ajouter d'autres tests d’intégration
  });
}
'''
  };

  final files = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where((file) => !file.path.contains('modules/'));

  for (final file in files) {
    final name = p.basenameWithoutExtension(file.path);
    for (final type in types) {
      final dir = Directory('${testBase.path}/$type');
      dir.createSync(recursive: true);

      final testFile = File('${dir.path}/${name}_$type_test.dart');
      if (!testFile.existsSync()) {
        testFile.writeAsStringSync(templates[type]!(name));
        print('✅ Test généré : ${testFile.path}');
      } else {
        print('⏭️ Déjà présent : ${testFile.path}');
      }
    }
  }

  print('\n🎉 Génération des tests globaux terminée !');
}
