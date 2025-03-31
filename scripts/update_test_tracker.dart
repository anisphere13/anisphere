import 'dart:io';

void main() {
  final libModulesDir = Directory('lib/modules');
  final libCoreDir = Directory('lib');
  final testDir = Directory('test');
  final trackerFile = File('docs/test_tracker.md');

  if (!testDir.existsSync()) {
    print('❌ Dossier test/ introuvable.');
    exit(1);
  }

  final buffer = StringBuffer()
    ..writeln('# 📋 Tracker des tests manquants\n')
    ..writeln('| Fichier | Type attendu | Test présent | Chemin du test |')
    ..writeln('|--------|--------------|--------------|----------------|');

  // 🔹 1. Vérification des modules (lib/modules/xxx)
  if (libModulesDir.existsSync()) {
    for (final module in libModulesDir.listSync()) {
      if (module is! Directory) continue;
      final moduleName = module.uri.pathSegments.last.replaceAll('/', '');
      final testModulePath = 'test/test_${moduleName}_module';

      for (final type in ['unit', 'widget', 'integration']) {
        final expectedPath = '$testModulePath/$type/${moduleName}_$type_test.dart';
        final exists = File(expectedPath).existsSync();
        buffer.writeln('| $moduleName | $type | ${exists ? "✅" : "❌"} | ${exists ? expectedPath : "_Aucun test trouvé_"} |');
      }
    }
  }

  // 🔹 2. Vérification du noyau et global (lib/*.dart)
  for (final file in libCoreDir.listSync()) {
    if (file is! File || !file.path.endsWith('.dart') || file.path.contains('/modules/')) continue;
    final fileName = file.uri.pathSegments.last;
    final nameWithoutExt = fileName.replaceAll('.dart', '').replaceAll('_screen', '').replaceAll('_service', '');
    final lower = nameWithoutExt.toLowerCase();

    for (final type in ['unit', 'widget', 'integration']) {
      final expectedPath = 'test/noyau/$type/${lower}_${type}_test.dart';
      final exists = File(expectedPath).existsSync();
      buffer.writeln('| $fileName | $type | ${exists ? "✅" : "❌"} | ${exists ? expectedPath : "_Aucun test trouvé_"} |');
    }
  }

  trackerFile.createSync(recursive: true);
  trackerFile.writeAsStringSync(buffer.toString());
  print('✅ Fichier généré : docs/test_tracker.md');
}
