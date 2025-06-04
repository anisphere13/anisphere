// scripts/generate_test_skeletons.dart
// Générateur automatique de squelettes de tests pour AniSphère

import 'dart:io';

final List<String> mainFolders = [
  'lib/modules/noyau',
  'lib/modules',
];

final Map<String, String> testTypes = {
  'models': 'unit',
  'services': 'unit',
  'logic': 'unit',
  'providers': 'unit',
  'widgets': 'widget',
  'screens': 'widget',
};

void main() async {
  final testDir = Directory('test');
  if (!testDir.existsSync()) {
    testDir.createSync(recursive: true);
    print('✅ Dossier /test créé.');
  }

  final testTracker = File('test/test_tracker.md');
  final trackerLines = <String>[];
  trackerLines.add('# Test Tracker AniSphère');
  trackerLines.add('| Fichier test | Type | Source | Statut |');
  trackerLines.add('|--------------|------|--------|--------|');

  for (final folder in mainFolders) {
    final root = Directory(folder);
    if (!root.existsSync()) continue;

    for (final module in root.listSync(recursive: false)) {
      if (module is! Directory) continue;
      final moduleName = module.path.split('/').last;

      for (final subdir in testTypes.keys) {
        final dir = Directory('${module.path}/$subdir');
        if (!dir.existsSync()) continue;

        for (final file in dir.listSync()) {
          if (file is! File || !file.path.endsWith('.dart')) continue;
          final fileName = file.uri.pathSegments.last;
          final baseName = fileName.replaceAll('.dart', '');
          final testType = testTypes[subdir];

          // Emplacement test
          final testPath =
              'test/${moduleName == "noyau" ? "noyau" : "modules/$moduleName"}/$testType/${baseName}_test.dart';
          final testFile = File(testPath);
          testFile.createSync(recursive: true);

          // Génère le squelette de test
          final sourceImport = file.path.replaceFirst('lib/', 'package:anisphere/');
          final content = '''
/// Copilot Prompt : Test automatique généré pour $baseName.dart ($testType)
import 'package:flutter_test/flutter_test.dart';
import '$sourceImport';

void main() {
  test('$baseName fonctionne (test auto)', () {
    // TODO : compléter le test pour $baseName.dart
    expect(true, isTrue); // À remplacer par un vrai test
  });
}
''';
          testFile.writeAsStringSync(content);
          print('📝 Squelette créé : $testPath');
          trackerLines.add('| $testPath | $testType | $sourceImport | À faire |');
        }
      }
    }
  }

  // Écriture du tracker markdown
  testTracker.writeAsStringSync(trackerLines.join('\n'));
  print('\n✅ Génération terminée. Statut dans test/test_tracker.md');
}
