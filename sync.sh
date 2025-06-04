#!/bin/bash

echo "Sauvegarde Git en cours..."

git add .
git commit -m "Sauvegarde automatique $(date '+%Y-%m-%d %H:%M')"
git push

echo "✅ Sauvegarde terminée."
echo "Synchronisation des données AniSphère…"
git pull origin main
dart scripts/update_test_tracker.dart
dart scripts/update_suivi_taches.dart
dart scripts/update_noyau_suivi.dart
flutter test
