#!/bin/bash

set -e

echo "🚀 Démarrage des tests de suivi automatique dans Docker (Flutter 3.22.1)..."

# Vérifie que Docker est bien installé
if ! command -v docker &> /dev/null; then
  echo "❌ Docker n'est pas installé. Abandon."
  exit 1
fi

# Liste des scripts à exécuter
scripts=(
  "scripts/update_test_tracker.dart"
  "scripts/update_suivi_taches.dart"
  "scripts/update_noyau_suivi.dart"
)

for script in "${scripts[@]}"; do
  echo "▶️  Exécution de $script..."
  docker run --rm -v "$PWD":/app -w /app ghcr.io/cirruslabs/flutter:3.22.1 dart "$script"
done

echo "✅ Tous les scripts exécutés avec succès !"
