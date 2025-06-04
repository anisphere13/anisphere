#!/bin/bash

# 🚀 Script de synchronisation AniSphère
# Sauvegarde Git + MAJ docs + exécution des tests Flutter

set -e  # Stoppe le script si une commande échoue

echo ""
echo "🔄 ⏳ Sauvegarde Git en cours..."

# Ajout des fichiers
git add .

# Vérifie s'il y a des modifications à committer
if git diff --cached --quiet; then
  echo "⚠️  Aucun changement à sauvegarder."
else
  git commit -m "📦 Sauvegarde automatique $(date '+%Y-%m-%d %H:%M')"
  git push
  echo "✅ Commit & push terminés."
fi

echo ""
echo "🔁 ⏳ Pull des dernières modifications depuis GitHub…"
git pull origin main

echo ""
echo "📚 📊 Mise à jour des suivis AniSphère..."
dart scripts/update_test_tracker.dart
dart scripts/update_suivi_taches.dart
dart scripts/update_noyau_suivi.dart
echo "✅ Suivis Markdown mis à jour."

echo ""
echo "🧪 🔬 Lancement des tests Flutter..."
flutter test || { echo "❌ Échec des tests. Corrige les erreurs."; exit 1; }

echo ""
echo "🎉 ✅ Synchronisation terminée avec succès."
