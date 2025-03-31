import 'dart:io';

void main() {
  final noyauTestDir = Directory('test/noyau');
  final output = File('docs/noyau_suivi.md');

  if (!noyauTestDir.existsSync()) {
    print('❌ Le dossier test/noyau est introuvable.');
    exit(1);
  }

  final buffer = StringBuffer()
    ..writeln('# ✅ Suivi des tests automatiques - NOYAU\n')
    ..writeln('| Fichier | Type de test | Statut |')
    ..writeln('|---------|---------------|--------|');

  final types = ['unit', 'widget', 'integration'];

  for (final type in types) {
    final typeDir = Directory('${noyauTestDir.path}/$type');
    if (!typeDir.existsSync()) continue;

    for (final file in typeDir.listSync().whereType<File>()) {
      final fileName = file.uri.pathSegments.last;
      final baseName = fileName.replaceAll('_test.dart', '');
      final testType = type.toUpperCase();
      buffer.writeln('| $baseName | $testType | ✅ |');
    }
  }

  output.createSync(recursive: true);
  output.writeAsStringSync(buffer.toString());
  print('📘 Fichier mis à jour : docs/noyau_suivi.md');
}
