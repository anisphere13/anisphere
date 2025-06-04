#!/bin/bash

echo "Sauvegarde Git en cours..."

git add .
git commit -m "Sauvegarde automatique $(date '+%Y-%m-%d %H:%M')"
git push

echo "✅ Sauvegarde terminée."
