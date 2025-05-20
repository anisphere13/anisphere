/// 🛠 Script Dart pour corriger tous les imports du noyau après réorganisation
/// À exécuter avec : dart scripts/fix_imports_noyau.dart
library;

import 'dart:io';

final replacements = {
  // Screens déplacés
  'package:anisphere/screens/animals_screen.dart': 'package:anisphere/modules/noyau/screens/animals_screen.dart',
  'package:anisphere/screens/home_screen.dart': 'package:anisphere/modules/noyau/screens/home_screen.dart',
  'package:anisphere/screens/main_screen.dart': 'package:anisphere/modules/noyau/screens/main_screen.dart',
  'package:anisphere/screens/modules_screen.dart': 'package:anisphere/modules/noyau/screens/modules_screen.dart',
  'package:anisphere/screens/share_screen.dart': 'package:anisphere/modules/noyau/screens/share_screen.dart',
  'package:anisphere/screens/register_screen.dart': 'package:anisphere/modules/noyau/screens/register_screen.dart',

  // Services déplacés
  'package:anisphere/services/app_initializer.dart': 'package:anisphere/modules/noyau/services/app_initializer.dart',
  'package:anisphere/services/firebase_service.dart': 'package:anisphere/modules/noyau/services/firebase_service.dart',
  'package:anisphere/services/local_storage_service.dart': 'package:anisphere/modules/noyau/services/local_storage_service.dart',
};

void main() {
  final directory = Directory('lib');

  if (!directory.existsSync()) {
    stderr.writeln('❌ Le dossier "lib" est introuvable.');
    return;
  }

  final dartFiles = directory
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  for (final file in dartFiles) {
    final originalContent = file.readAsStringSync();
    String updatedContent = originalContent;

    replacements.forEach((oldImport, newImport) {
      updatedContent = updatedContent.replaceAll(oldImport, newImport);
    });

    if (updatedContent != originalContent) {
      file.writeAsStringSync(updatedContent);
      stderr.writeln('✅ Imports mis à jour dans ${file.path}');
    }
  }

  stderr.writeln('\n🎉 Tous les imports ont été corrigés.');
}
