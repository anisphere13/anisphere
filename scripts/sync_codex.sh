#!/bin/bash

# Script d'intégration Codex > main, avec sécurité, rebase et résolution propre

echo "➡️ Synchronisation Codex -> main (cursus optimal AniSphère)"

# Saisir le nom du dépôt/dossier courant (par défaut .)
read -p "Nom du dossier du dépôt (par défaut: .) : " DEPOT
DEPOT=${DEPOT:-.}

cd "$DEPOT" || { echo "❌ Dossier $DEPOT introuvable !"; exit 1; }

# Saisir la branche Codex à intégrer (autocompletion possible dans Bash classique)
echo
git branch -r | grep "codex/"
read -p "Nom exact de la branche Codex à fusionner (ex: codex/implement-notification-feedback-service) : " CODEX_BRANCH

if [ -z "$CODEX_BRANCH" ]; then
    echo "❌ Aucune branche Codex précisée."
    exit 1
fi

# 1. Sauvegarde de ton travail en cours
echo "🔒 [1/6] Vérification et sauvegarde de ton travail..."
git status
git add .
git commit -m "WIP: sauvegarde avant synchro Codex" || echo "(Pas de modif à committer)"

# 2. Récupération des dernières mises à jour distantes
echo "🔄 [2/6] Récupération des branches distantes..."
git fetch origin

# 3. Basculer sur la branche Codex, la mettre à jour
echo "🔁 [3/6] Checkout et pull Codex ($CODEX_BRANCH)..."
git checkout "$CODEX_BRANCH" || { echo "❌ Impossible de checkout la branche Codex."; exit 1; }
git pull origin "$CODEX_BRANCH"

# 4. Basculer sur main et rebase sur le dernier main
echo "🏷️ [4/6] Passage sur main et mise à jour (rebase)..."
git checkout main
git pull origin main --rebase

# 5. Merge Codex dans main
echo "🔀 [5/6] Merge Codex dans main..."
git merge "$CODEX_BRANCH"

echo "⚠️ Si des conflits s'affichent, corrige-les dans VS Code puis tape :"
echo "    git add . && git commit -m 'Résolution de conflits Codex dans main'"
read -p "Appuie sur [Entrée] pour continuer après résolution des conflits..."

# 6. Push sur GitHub
echo "⬆️ [6/6] Push main vers GitHub..."
git push origin main

# 7. (optionnel) Suppression locale de la branche Codex
read -p "Supprimer la branche Codex localement ? [y/N] : " DELETE
if [[ $DELETE == "y" || $DELETE == "Y" ]]; then
    git branch -d "$CODEX_BRANCH"
    echo "🗑️ Branche Codex supprimée localement."
fi

echo "✅ Synchronisation terminée. Dépôt à jour !"
