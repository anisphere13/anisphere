🛠️ 6__technos_par_module.md — Technologies utilisées par module AniSphère

Ce fichier décrit les technologies, bibliothèques et outils utilisés dans le projet AniSphère, classés par noyau et modules fonctionnels. Il permet d’avoir une vision claire des dépendances et de faciliter le suivi des performances, des tests et de l’architecture.

🔹 Noyau central

Flutter : Base de l'application multiplateforme (iOS, Android, Web, desktop).

Hive : Stockage local ultra-rapide (données utilisateurs, animaux, modules).

Firebase Auth : Authentification sécurisée (Email, Google, Apple).

Firebase Firestore : Base cloud pour la synchronisation différée.

Firebase Storage : Stockage de fichiers compressés (OCR, photos...)

Firebase Remote Config : Gestion dynamique des versions, modules et fonctionnalités.

Provider : Gestion des états globaux (user, animal, modules actifs).

Github Actions : Tests automatisés, CI/CD, scripts de suivi.

TFLite : IA locale pour OCR et détection embarquée.

OpenCV (via native plugin) : Analyse d’image, tri IA, reconnaissance.

flutter_secure_storage : Stockage local chiffré de données sensibles.
path : Gestion des chemins et manipulations de fichiers.

shared_preferences : Gestion des préférences utilisateur (thème, vues, tutoriels) et stockage local de la langue choisie.

firebase_crashlytics : Suivi des erreurs en production.

intl, flutter_localizations : Gestion du multilingue Flutter.
Tous les modules utilisent `AppLocalizations` pour les textes, aucun système i18n n'est redéclaré.

🩺 Module Santé

Tesseract / TFLite : OCR carnet santé (ordonnances, vaccins).

Charts_flutter : Graphiques d’évolution (poids, traitements...)

PDF / printing : Export du carnet santé en PDF

Local Notifications : Rappels de traitements et vaccinations

cloud_functions : Export vérifié et sécurisé (PDF pro)

pdf_text : OCR sur fichiers PDF existants

🧠 Module Éducation

Base éducative locale : Liste embarquée des exercices standards

IA personnalisée (TFLite) : Suggestions d'exercices selon profil

Audio Player : Lecture de playlists sonores éducatives

Hive : Sauvegarde de la progression

confetti / fl_chart : Feedback visuel lors des validations

draggable_grid_view : Organisation des objectifs éducatifs

microphone / recorder : Écoute de commandes vocales (rappel, consignes)

🐾 Module Dressage

Google Maps / Flutter Map : Affichage des parcours (pistage, sport)

Geolocator / location : Enregistrement de traces GPS

TFLite / OpenCV : Détection d’objets, reconnaissance d’action

background_locator_2 : Enregistrement GPS même en arrière-plan

flutter_compass : Orientation et direction dans l'espace (pistage, agility)

ar_flutter_plugin : Réalité augmentée (entraînement interactif)

👥 Module Communauté

Firebase Firestore : Stockage des profils, échanges, réputation

Cloud Functions : Validation des échanges, récompenses

Flutter Webview / QR : Partage des profils, accès simplifié

Algolia (optionnel) : Recherche rapide utilisateurs/animaux

flutter_map_marker_cluster : Regroupement d’utilisateurs sur carte

firebase_messaging + local_notifications : Notification combinée locale et cloud

🌳 Module Généalogie

graphview : Affichage interactif de l’arbre familial

csv / gedcom : Import et export de pedigrees

Hive : Stockage local des ascendances

share_plus : Partage des profils publics

🌐 Site compagnon (module intégré)

Flutter Web : Interface web miroir

Firebase Hosting : Hébergement statique sécurisé

Deep Linking : Synchronisation directe app ↔ site

next.js (en option futur) : site web plus flexible si besoin

Strapi CMS (en option futur) : gestion de contenu sans coder

🧪 Tests & Automatisation

flutter_test : Tests unitaires & widget

integration_test : Scénarios utilisateur

mockito / fake_async : Simulation d’environnement

generate_test_module.dart : Génération automatique de fichiers de test

update_test_tracker.dart : Mise à jour continue du tracker de tests

📦 Utilitaires communs à tous les modules

Image Picker : Ajout de photos (santé, profil, activité)

Path_provider : Gestion du cache, documents, export

Intl : Traductions, formats de date, langues

Compression : Réduction de poids avant envoi (images, fichiers)

qr_flutter / NFC plugin : Génération de QR code animal, page publique

💳 Paiement & Monétisation (à venir)

in_app_purchase : Achats intégrés (iOS/Android)

stripe : Paiements web

RevenueCat : Gestion multiplateforme des abonnements (optionnelle)

📊 Performance & Analyse (à venir)

Datadog / Sentry : Suivi des performances, crashs, analytics IA

Firebase Analytics : Comportements utilisateurs (activations modules, navigation...)

🧠 IA avancée (idées futures)

Reconnaissance comportementale par caméra (pelage, posture, expression)

IA scoring éducatif (analyse historique et prédiction des progrès)

Speech-to-Bark (reconnaissance d’aboiement) : projet de recherche vocal canin

