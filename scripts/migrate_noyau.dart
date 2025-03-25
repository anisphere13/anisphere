import 'dart:io';

void main() {
  final Map<String, String> importCorrections = {
    // Pour les modèles déplacés
    "import '../models/user_model.dart'": "import 'package:anisphere/modules/noyau/models/user_model.dart';",
    "import '../models/animal_model.dart'": "import 'package:anisphere/modules/noyau/models/animal_model.dart';",

    // Corriger les imports de local_storage_service.dart
    "import 'package:anisphere/modules/noyau/services/local_storage_service.dart'": "import 'package:anisphere/services/local_storage_service.dart';",

    // Corriger main_screen.dart partout
    "import 'main_screen.dart'": "import 'package:anisphere/screens/main_screen.dart';",

    // FirebaseService (dans user_provider.dart)
    "import 'package:anisphere/modules/noyau/services/firebase_service.dart'": "import 'package:anisphere/services/firebase_service.dart';",

    // Remplacer les anciens imports relatifs obsolètes si encore présents
    "import '../../models/user_model.dart'": "import 'package:anisphere/modules/noyau/models/user_model.dart';",
    "import '../../models/animal_model.dart'": "import 'package:anisphere/modules/noyau/models/animal_model.dart';"
  };

  final projectDir = Directory('lib/');
  final dartFiles = projectDir.listSync(recursive: true).whereType<File>().where((file) => file.path.endsWith('.dart'));

  for (final file in dartFiles) {
    String content = file.readAsStringSync();
    bool updated = false;

    importCorrections.forEach((wrong, correct) {
      if (content.contains(wrong)) {
        content = content.replaceAll(wrong, correct);
        updated = true;
      }
    });

    if (updated) {
      file.writeAsStringSync(content);
      print('✅ Import corrigé dans : ${file.path}');
    }
  }

  print('\n🎯 Tous les imports critiques ont été mis à jour.');
}
