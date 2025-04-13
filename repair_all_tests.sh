#!/bin/bash

echo "🔧 AniSphère — Réparation complète et tests locaux 🧪"

# Étape 1 — Mise à jour des dépendances Flutter
echo "📦 flutter pub get..."
flutter pub get

# Étape 2 — Ajout sécurisé des méthodes LocalStorageService
LOCAL_STORAGE_FILE="lib/modules/noyau/services/local_storage_service.dart"
echo "🔍 Vérification de LocalStorageService.dart..."
if ! grep -q "static dynamic get(" "$LOCAL_STORAGE_FILE"; then
  echo "⚠️  Ajout des méthodes manquantes (get/set/remove)..."
  sed -i '/class LocalStorageService {/a\
  static final _box = Hive.box("settings");\
\
  static dynamic get(String key, {dynamic defaultValue}) => _box.get(key, defaultValue: defaultValue);\
  static Future<void> set(String key, dynamic value) async => await _box.put(key, value);\
  static Future<void> remove(String key) async => await _box.delete(key);\
' "$LOCAL_STORAGE_FILE"
  echo "✅ Méthodes ajoutées."
else
  echo "✅ Méthodes déjà présentes dans LocalStorageService."
fi

# Étape 3 — Suppression redéfinitions parasites
echo "🧹 Nettoyage : suppression doublons dans LocalStorageService.dart..."
awk '!seen[$0]++' "$LOCAL_STORAGE_FILE" > "$LOCAL_STORAGE_FILE.tmp" && mv "$LOCAL_STORAGE_FILE.tmp" "$LOCAL_STORAGE_FILE"

# Étape 4 — Génération des mocks
echo "🛠️  Génération des mocks..."
dart run build_runner build --delete-conflicting-outputs

# Étape 5 — Patch d'initialisation Firebase dans tests
echo "⚙️ Patch d’initialisation Firebase dans les tests..."
find test/ -name "*.dart" -exec grep -q "FirebaseFirestore.instance" {} \; -exec grep -q "Firebase.initializeApp()" {} \; -o -exec sed -i '1i\
import '\''package:firebase_core/firebase_core.dart'\'';\
import '\''package:flutter_test/flutter_test.dart'\'';\
void main() async {\
  TestWidgetsFlutterBinding.ensureInitialized();\
  await Firebase.initializeApp();\
' {} \;

# Étape 6 — Exécution des tests
echo "🧪 Lancement des tests..."
flutter test --coverage

# Étape 7 — Mise à jour des suivis Markdown
echo "📄 Mise à jour des suivis..."
dart scripts/update_test_tracker.dart
dart scripts/update_suivi_taches.dart
dart scripts/update_noyau_suivi.dart

echo "🎉 Fin de réparation. Tests terminés. Suivis à jour."
