#!/bin/bash

echo "🧹 Correction finale des erreurs Flutter Analyze..."

# ✅ Correction logique dans user_provider.dart (contains + await + fix bracket)
sed -i "s/\[ConnectivityResult.wifi, ConnectivityResult.mobile\] == connectivityResult/\[ConnectivityResult.wifi, ConnectivityResult.mobile\].contains(connectivityResult)/" lib/modules/noyau/providers/user_provider.dart

# ✅ Fix 'await' sur void → suppression car déjà awaité correctement ci-dessus
sed -i '145s/^ *//' lib/modules/noyau/providers/user_provider.dart

# ✅ Correction test : renommage userServiceUnderTest → userService
sed -i "s/userServiceUnderTest/userService/" test/noyau/unit/user_service_test.dart

# ✅ Suppression de l'import inutilisé dans generate_test_module.dart
sed -i "/flutter\/foundation\.dart/d" scripts/generate_test_module.dart

# ✅ Suppression de tous les 'print' → stderr.writeln pour usage console (scripts batch uniquement)
for file in scripts/*.dart; do
  sed -i "s/print(/stderr.writeln(/g" "$file"
done

# ✅ Suppression des duplicate_ignore sur must_be_immutable générés par mockito
find test/ -name "*.mocks.dart" -exec sed -i '/must_be_immutable/d' {} \;

# ✅ (Optionnel) Ajoute un ignore global si nécessaire (au cas où)
for file in $(find test/ -name "*.mocks.dart"); do
  sed -i '1s/^/\/\/ ignore_for_file: must_be_immutable\n/' "$file"
done

echo "✅ Terminé ! Tu peux relancer : flutter analyze && flutter test"
