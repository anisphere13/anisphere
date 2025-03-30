import 'dart:io';
import 'package:flutter/foundation.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    debugPrint('❌ Merci de fournir un nom de module :');
    debugPrint('   Exemple : dart run scripts/generate_test_module.dart sante');
    exit(1);
  }

  final moduleName = args[0].toLowerCase();
  final basePath = 'test/test_${moduleName}_module';
  final types = ['unit', 'widget', 'integration'];

  // Crée aussi le dossier du module dans lib/modules/ si non existant
  final libModuleDir = Directory('lib/modules/$moduleName');
  if (!libModuleDir.existsSync()) {
    libModuleDir.createSync(recursive: true);
    File('${libModuleDir.path}/README.md').writeAsStringSync(
      '# Module $moduleName\n\nCe dossier contient le code source du module `$moduleName`.',
    );
    debugPrint('📁 Dossier créé : ${libModuleDir.path}');
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

    final file = File('$basePath/$type/${moduleName}_$type_test.dart');
    if (!file.existsSync()) {
      file.writeAsStringSync(templates[type]!);
      debugPrint('✅ Fichier créé : ${file.path}');
    } else {
      debugPrint('⚠️  Déjà existant : ${file.path}');
    }
  }

  debugPrint('\n🎉 Module "$moduleName" prêt dans $basePath');
}
