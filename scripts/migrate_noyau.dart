import 'dart:io';

void main() {
  final Map<String, String> filesToMove = {
    'lib/models/animal_model.dart': 'lib/modules/noyau/models/animal_model.dart',
    'lib/models/user_model.dart': 'lib/modules/noyau/models/user_model.dart',
    'lib/services/auth_service.dart': 'lib/modules/noyau/services/auth_service.dart',
    'lib/services/user_service.dart': 'lib/modules/noyau/services/user_service.dart',
    'lib/screens/login_screen.dart': 'lib/modules/noyau/screens/login_screen.dart',
    'lib/screens/register_screen.dart': 'lib/modules/noyau/screens/register_screen.dart',
    'lib/screens/splash_screen.dart': 'lib/modules/noyau/screens/splash_screen.dart',
    'lib/screens/user_profile_screen.dart': 'lib/modules/noyau/screens/user_profile_screen.dart',
    'lib/providers/user_provider.dart': 'lib/modules/noyau/providers/user_provider.dart',
  };

  for (var entry in filesToMove.entries) {
    moveFile(entry.key, entry.value);
  }

  print('\n✅ Migration terminée. Maintenant, correction des imports...');
  updateImports();
  print('\n🎉 Migration du noyau terminée avec succès !');
}

void moveFile(String oldPath, String newPath) {
  final oldFile = File(oldPath);
  final newFile = File(newPath);

  if (oldFile.existsSync()) {
    newFile.parent.createSync(recursive: true);
    oldFile.renameSync(newPath);
    print('📂 Déplacé : $oldPath ➝ $newPath');
  } else {
    print('⚠️ Fichier non trouvé : $oldPath');
  }
}

void updateImports() {
  final projectDir = Directory('lib/');
  final dartFiles = projectDir.listSync(recursive: true).whereType<File>().where((file) => file.path.endsWith('.dart'));

  for (var file in dartFiles) {
    String content = file.readAsStringSync();
    content = content.replaceAll("import 'package:anisphere/models/", "import 'package:anisphere/modules/noyau/models/");
    content = content.replaceAll("import 'package:anisphere/screens/", "import 'package:anisphere/modules/noyau/screens/");
    content = content.replaceAll("import 'package:anisphere/services/", "import 'package:anisphere/modules/noyau/services/");
    content = content.replaceAll("import 'package:anisphere/providers/", "import 'package:anisphere/modules/noyau/providers/");
    file.writeAsStringSync(content);
  }
  print('🔄 Imports mis à jour !');
}
