🗺️ 2__roadmap.md — Roadmap de développement AniSphère

Ce document définit les grandes étapes stratégiques du projet AniSphère. Il est mis à jour au fur et à mesure de l’évolution du développement. Il suit une logique modulaire et progressive, avec séparation entre noyau et modules.

🚀 Phase 1 — Noyau minimal fonctionnel (MVP Core)

Objectifs :

Authentification (email / Google / Apple)

Création et gestion du compte utilisateur

Stockage local (Hive) + synchronisation Firebase (animaux, utilisateur)

Connexion et reconnexion automatique hors ligne

Interface de base (Login / MainScreen / Paramètres)

Structure modulaire activable

Statut :

✅ Authentification email / Hive / Firebase : OK
✅ Reconnexion hors ligne : OK
✅ Gestion compte utilisateur : OK
✅ Architecture des modules : OK
🔄 En cours : synchronisation automatique animaux (local + cloud)

🧠 Phase 2 — IA maîtresse & automatisations

Objectifs :

Intégration d’une IA centrale dans le noyau

IA de compression, coûts Firebase, notifications intelligentes

Script de réparation automatique en cas de bug

Suggestions automatiques de modules selon profil utilisateur / animal

Outils prévus :

TensorFlow Lite + Firebase Functions

Surveillance IA du trafic / synchronisation / erreurs locales

Ajout de ai_core_service.dart dans le noyau

Statut :

🟡 À structurer

🧪 Phase 3 — Tests, CI/CD & Scripts internes

Objectifs :

Mise en place complète des tests auto

Génération automatique des fichiers de tests

Intégration GitHub Actions : test + build

Scripts de suivi automatisé (sync_docs.sh, update_test_tracker.dart...)

Statut :

✅ Dossier test/ propre créé
✅ Scripts generate_test_module.dart & update_test_tracker.dart : OK
🟡 À intégrer dans pipeline GitHub Actions

🧩 Phase 4 — Modules essentiels (Santé, Éducation, Communauté)

Modules à créer :

🩺 Santé

OCR carnet de santé (vaccins, traitements, allergies)

Gestion des rappels & export PDF

IA de suivi santé (statistiques, alertes)

🧠 Éducation

Base d’exercices par niveau + IA adaptative

Suivi de socialisation et playlist sonore

Validation manuelle ou auto des acquis

👥 Communauté

Système Sphères (échange de services)

Profils utilisateurs + carte interactive

Missions + réputation + entraide locale

Statut :

🟡 Phase préparatoire (data models + UI screens en cours)

📱 Phase 5 — UI/UX améliorée + Magasin de Modules

Objectifs :

Ajout du magasin de modules (activation/désactivation)

Navigation inspirée Samsung Health (4 onglets fixes)

Modes clair/sombre

Tutoriel interactif (onboarding)

Ajout rapide d’un animal via action rapide (slide up)

Statut :

🔲 À développer à partir des composants de base
✅ internationalisation activée

🌍 Phase 6 — Site compagnon & synchronisation

Objectifs :

Site de présentation + téléchargement

Fiches modules + documentation utilisateur

Page publique animal perdu (reliée à QR code)

Statistiques anonymisées & communauté

Synchronisation dynamique avec l’app
- Activation possible de l’analyse vidéo IA dans le cloud une fois le modèle économique validé

Statut :

🟡 Cahier des charges en cours
🔄 Intégration du site dans les modules planifiée

💳 Phase 7 — Monétisation & modules avancés

Objectifs :

Mise en place des offres gratuites / premium


Déblocage de certains modules payants

Gestion des abonnements via Firebase + Stripe

Statut :

🔲 À modéliser (liée au module économique 8__modèle_éco.md)

🔁 Phases récurrentes / parallèles

🔄 Maintenance IA & core

Suivi des performances IA + Firebase

Auto-réparation erreurs mineures via IA

Suggestions dynamiques de modules selon usage

🧪 Amélioration continue des tests

Ajout automatique à chaque nouveau module

Suivi du fichier test_tracker.md

🗃️ Documentation vivante

Synchronisation continue des fichiers *.md

README.md, README_DEV.md, 0__instructions.md toujours à jour

🧭 Prochaine mise à jour

Revoir la structure des modules avec les catégories validées : Santé, Éducation, Dressage, Communauté.

Intégrer la feuille de route dans l’interface utilisateur (affichage dynamique de la progression ?)

Ajouter lien dynamique vers les fiches modules à venir dans le magasin de modules

