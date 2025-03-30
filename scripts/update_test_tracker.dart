import 'dart:io';

void main() {
  final libDir = Directory('lib/modules');
  final testDir = Directory('test');
  final trackerFile = File('docs/test_tracker.md');

  if (!libDir.existsSync() || !testDir.existsSync()) {
    print('❌ Dossier lib/modules/ ou test/ introuvable.');
    exit(1);
  }

  final buffer = StringBuffer()
    ..writeln('# 📋 Tracker des tests manquants\n')
    ..writeln('> Mise à jour automatique à chaque push via GitHub Actions.\n')
    ..writeln('| Module | Type | Présent ? | Chemin du test |')
    ..writeln('|--------|------|-----------|----------------|');

  final modules = libDir
      .listSync()
      .whereType<Directory>()
      .map((dir) => dir.uri.pathSegments.last.replaceAll('/', ''))
      .toList()
    ..sort();

  for (final moduleName in modules) {
    final testModulePath = 'test/test_${moduleName}_module';

    for (final type in ['unit', 'widget', 'integration']) {
      final expectedPath = '$testModulePath/$type/${moduleName}_$type_test.dart';
      final exists = File(expectedPath).existsSync();

      final pathDisplay = exists
          ? '[$expectedPath]($expectedPath)'
          : '_Aucun test trouvé_';

      buffer.writeln('| $moduleName | $type | ${exists ? "✅" : "❌"} | $pathDisplay |');
    }

    buffer.writeln('| | | | |'); // Ligne vide pour séparation
  }

  trackerFile.createSync(recursive: true);
  trackerFile.writeAsStringSync(buffer.toString());
  print('✅ Fichier généré : docs/test_tracker.md');
}
