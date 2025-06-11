#!/bin/bash

echo "🔍 Analyse Flutter en cours..."
flutter analyze > .analyze_log.txt

echo "📁 Extraction des fichiers avec erreurs..."
grep -oP "(?<=• ).*\.dart(?=:\d+:\d+)" .analyze_log.txt | sort | uniq > .error_files.txt

echo "📂 Fichiers détectés avec erreurs :"
cat .error_files.txt

echo "📌 Insertion tag de réparation dans chaque fichier..."
while read -r file; do
  if [[ -f "$file" ]]; then
    sed -i '1i// 🔧 FIX ME (flutter analyze)' "$file"
  fi
done < .error_files.txt

echo "✅ Tous les fichiers sont annotés. Tu peux les ouvrir un par un avec Copilot et lui dire :"
echo "➡️ Répare automatiquement ce fichier (flutter analyze). Respecte l’architecture AniSphère."
