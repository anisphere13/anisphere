// 🛠 Génère la structure de test pour un module.
// À exécuter avec : `flutter pub run scripts/generate_test_module.dart <nom>`
// (Pour un environnement pur Dart, utilisez `package:firebase_dart` puis
//  lancez : `dart run scripts/generate_test_module.dart <nom>`.)
import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('❌ Merci de fournir un nom de module :');
    stderr.writeln('   Exemple : flutter pub run scripts/generate_test_module.dart sante');
    exit(1);
  }

  final moduleName = args[0].toLowerCase();
  // Les tests suivent la même arborescence que lib/modules/
  // Exemple : test/sante/unit/...
  final basePath = 'test/$moduleName';
  final types = ['unit', 'widget', 'integration'];

  // Crée aussi le dossier du module dans lib/modules/ si non existant
  final libModuleDir = Directory('lib/modules/$moduleName');
  if (!libModuleDir.existsSync()) {
    libModuleDir.createSync(recursive: true);
    File('${libModuleDir.path}/README.md').writeAsStringSync(
      '# Module $moduleName\n\nCe dossier contient le code source du module `$moduleName`.',
    );
    stderr.writeln('📁 Dossier créé : ${libModuleDir.path}');
  }

  final templates = {
    'unit': """import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${moduleName.toUpperCase()} - Test unitaire', () {
    test('Addition simple', () {
      expect(1 + 1, equals(2));
    });

    // TODO: Ajouter d'autres tests unitaires ici
  });
}
""",
    'widget': """import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('${moduleName.toUpperCase()} - Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('${moduleName.toUpperCase()} Widget')),
    ));

    expect(find.text('${moduleName.toUpperCase()} Widget'), findsOneWidget);

    // TODO: Ajouter d'autres tests de widget ici
  });
}
""",
    'integration': """import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('${moduleName.toUpperCase()} - Test d’intégration', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('${moduleName.toUpperCase()} Integration')),
    ));

    expect(find.text('${moduleName.toUpperCase()} Integration'), findsOneWidget);

    // TODO: Ajouter d'autres tests d'intégration ici
  });
}
"""
  };

  for (final type in types) {
    final dir = Directory('$basePath/$type');
    dir.createSync(recursive: true);

    final typeTest = type; // ensures correct suffix
    final file = File('$basePath/$type/${moduleName}_$typeTest.dart');
    if (!file.existsSync()) {
      file.writeAsStringSync(templates[type]!);
      stderr.writeln('✅ Fichier créé : ${file.path}');
    } else {
      stderr.writeln('⚠️  Déjà existant : ${file.path}');
    }
  }

  stderr.writeln('\n🎉 Module "$moduleName" prêt dans $basePath');
}
