#!/bin/bash

echo "➡️ Synchronisation Codex -> main (cursus optimal AniSphère)"

# Saisir le nom du dossier du dépôt
read -p "Nom du dossier du dépôt (par défaut: .) : " DEPOT
DEPOT=${DEPOT:-.}

cd "$DEPOT" || { echo "❌ Dossier $DEPOT introuvable !"; exit 1; }

# Afficher toutes les branches distantes Codex pour choix rapide
echo
echo "Branches Codex distantes disponibles :"
git fetch origin
git branch -r | grep "codex/" | sed 's/origin\///'

read -p "Nom exact de la branche Codex à fusionner (ex: codex/corriger-erreurs-flutter-analyze) : " CODEX_BRANCH

if [ -z "$CODEX_BRANCH" ]; then
    echo "❌ Aucune branche Codex précisée."
    exit 1
fi

# Vérifie si la branche existe en local, sinon la crée depuis origin
if ! git show-ref --verify --quiet "refs/heads/$CODEX_BRANCH"; then
    echo "Branche locale absente, création depuis origin/$CODEX_BRANCH..."
    git checkout -b "$CODEX_BRANCH" "origin/$CODEX_BRANCH" || { echo "❌ Impossible de créer la branche locale."; exit 1; }
else
    git checkout "$CODEX_BRANCH" || { echo "❌ Impossible de checkout la branche Codex."; exit 1; }
    git pull origin "$CODEX_BRANCH"
fi

# 1. Sauvegarde du travail local
echo "🔒 [1/6] Sauvegarde du travail local..."
git status
git add .
git commit -m "WIP: sauvegarde avant synchro Codex" || echo "(Pas de modif à committer)"

# 2. Récupération des mises à jour distantes (main et codex)
echo "🔄 [2/6] git fetch origin"
git fetch origin

# 3. Checkout main et pull + rebase
echo "🏷️ [3/6] Passage sur main et mise à jour (rebase)..."
git checkout main
git pull origin main --rebase

# 4. Merge Codex dans main
echo "🔀 [4/6] Merge Codex dans main..."
git merge "$CODEX_BRANCH"

echo "⚠️ Si des conflits s'affichent, corrige-les dans VS Code puis tape :"
echo "    git add . && git commit -m 'Résolution de conflits Codex dans main'"
read -p "Appuie sur [Entrée] pour continuer après résolution des conflits..."

# 5. Push sur GitHub
echo "⬆️ [5/6] Push main vers GitHub..."
git push origin main

# 6. Suppression locale (optionnel)
read -p "Supprimer la branche Codex localement ? [y/N] : " DELETE
if [[ $DELETE == "y" || $DELETE == "Y" ]]; then
    git branch -d "$CODEX_BRANCH"
    echo "🗑️ Branche Codex supprimée localement."
fi

echo "✅ Synchronisation terminée. Dépôt à jour !"
