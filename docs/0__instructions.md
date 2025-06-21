📘 0__instructions.md — Directives Générales AniSphère

Ce fichier centralise les directives générales du projet AniSphère. Il permet de garder une vision claire des fondations du projet, de ses règles de développement et des décisions structurantes.

🧩 Vision globale

AniSphère est une application modulaire de suivi animal permettant :

Le suivi santé, comportemental et éducatif de chaque animal

L'intégration de modules activables selon les profils utilisateurs

L’usage combiné d’IA locale + cloud pour adapter l’expérience

Une expérience fluide, même sans connexion (Hive)

Le tout est géré autour d’un noyau central solide et léger, avec une architecture pensée pour la performance, la personnalisation et la modularité totale.

🔧 Règles de base du développement

Le projet utilise Flutter pour toutes les plateformes (mobile / web)

Le code est modulaire → chaque module est indépendant, dans lib/modules/

Le noyau gère uniquement :

Authentification (Firebase + Hive)

Stockage partagé (Hive / Firebase)

Gestion IA principale (optimisation, routage, coûts)

Notifications globales (et permission system)

Navigation, design système, base UI/UX

L’interface est claire, animée, inspirée de Samsung Health

Tous les textes, choix et graphismes doivent être accessibles et lisibles

L’application est multilingue et toutes les traductions sont centralisées dans le noyau
L’interface prend en charge **10 langues** grâce au fichier `i18n_service.dart` et aux ressources `.arb`
Tous les textes doivent passer par `AppLocalizations.of(context)` pour permettre la traduction automatique selon la langue choisie.
Les fichiers `.arb` se trouvent dans `lib/l10n/` et sont générés automatiquement ou traduits via script.
Le système multilingue est centralisé dans `lib/modules/noyau/i18n/`.
- Clés communes : `appTitle`, `mainScreenTitle`, `ai_score`, `breeder_name`, `breeder_email`, `breeder_phone`, `onboarding_title`, `onboarding_subtitle`, `onboarding_skip`, `onboarding_next`, `duplicate_animal_warning`, `duplicate_photo_warning`, `photo_timeline_title`.

🧠 Architecture IA

L’IA est découpée en 2 niveaux :

IA locale (TensorFlow Lite, Tesseract, OpenCV) : OCR, analyse comportementale, suggestions offline

IA cloud (Firebase + modèle custom) : recommandations intelligentes, analyse statistique, synchronisation intelligente

L’IA maîtresse est dans le noyau → elle oriente les décisions clés (stockage local ou cloud, compression, coût, etc.)

Chaque module peut avoir sa propre IA dédiée (OCR, apprentissage, prédiction...)

Voir aussi la sous-section **Gestion des modèles IA locaux** dans [7__ia.md](7__ia.md) pour le chargement et la mise à jour des modèles.

💾 Stockage optimisé

Utilisation de Hive en local pour toutes les données sensibles ou souvent consultées

Synchronisation différée vers Firebase (si l’utilisateur est connecté + stable)

Compression automatique des fichiers lourds avant envoi

Réduction des coûts Firebase par design (pas de requêtes inutiles, pas de streaming temps réel sauf besoin)

🔒 Données et sécurité

Seul l’email est requis à l’inscription

Le nom, téléphone et adresse restent stockés localement

Les modules peuvent demander des infos selon le profil (pro ou particulier)

L’authentification supporte Google / Apple / Email

Les données locales sont chiffrées

📚 Organisation du projet

Le projet est structuré par blocs indépendants :

noyau/ → gestion utilisateur, IA maîtresse, notifications, app shell

modules/ → 1 dossier par module (activable indépendamment)
Le module Superadmin est désormais séparé du noyau (voir `docs/suivi_superadmin.md`)

services/ → Firebase, Hive, IA, OCR, localisation, stockage

screens/ → interfaces générales (accueil, paramètres, onboarding...)

La documentation est dans docs/, les tests dans test/, les scripts d'automatisation dans scripts/.

🧪 Test & CI

GitHub Actions assure le test automatique à chaque push

Fichier test_tracker.md → suivi des tests à jour

Chaque module a son dossier dans /test/[module]/
🔗 Module Partage — Tâches & statut
- Base de partage local (QR code + export) : terminée
- Sauvegarde cloud facultative : en cours
- Gestion des permissions d'accès : prévu
- UI onglet Partage : à démarrer
- Tests module partage : à créer

Les scripts : generate_test_module.dart, update_test_tracker.dart, sync_docs.sh, train_ia_pipeline.py, upload_model_to_functions.sh

📅 Mise à jour continue

Ce fichier est mis à jour automatiquement lors des grandes décisions

Toute modification importante doit être notée ici ou dans un fichier lié (architecture, roadmap, suivi_noyau.md...)

📝 Liens associés

README.md → Présentation publique

README_DEV.md → Vue développeur

10__architecture.md → Structure complète et interconnexions

1__idees.md → Modules futurs

2__roadmap.md → Étapes projet à venir


