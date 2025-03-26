
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
    ..writeln('| Fichier | Type attendu | Test présent | Chemin du test |')
    ..writeln('|--------|--------------|--------------|----------------|');

  for (final module in libDir.listSync()) {
    if (module is! Directory) continue;
    final moduleName = module.uri.pathSegments.last.replaceAll('/', '');
    final testModulePath = 'test/test_\${moduleName}_module';

    for (final type in ['unit', 'widget', 'integration']) {
      final expectedPath = '\$testModulePath/\$type/\${moduleName}_\$type_test.dart';
      final exists = File(expectedPath).existsSync();
      buffer.writeln('| \$moduleName | \$type | \${exists ? "✅" : "❌"} | \${exists ? expectedPath : "_Aucun test trouvé_"} |');
    }
  }

  trackerFile.createSync(recursive: true);
  trackerFile.writeAsStringSync(buffer.toString());
  print('✅ Fichier généré : docs/test_tracker.md');
}
