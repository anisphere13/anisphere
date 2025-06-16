🐾 AniSphère — Application intelligente pour le suivi de la vie animale

AniSphère est une application modulaire, intuitive et évolutive qui accompagne les utilisateurs dans le suivi complet de leurs animaux. Grâce à une architecture hybride (local + cloud) et à une intelligence artificielle intégrée, AniSphère devient un véritable compagnon quotidien pour les particuliers, professionnels et associations.

🎯 Mission

Offrir à chaque utilisateur un suivi complet, intelligent et personnalisable de la santé, de l’éducation, du bien-être et des activités de ses animaux, tout en garantissant :

Une expérience utilisateur fluide et agréable

Une confidentialité maximale des données personnelles

Une intégration intelligente de l’IA au service de l’utilisateur

Une modularité totale selon les besoins de chaque profil

🧩 Fonctionnalités principales

Suivi santé complet : vaccins, ordonnances, carnet vétérinaire, rendez-vous

Modules d’éducation et de dressage : exercices, sociabilisation, pistage, concours

Reconnaissance visuelle & OCR : scannez le carnet vétérinaire ou une ordonnance pour l’intégrer automatiquement

Photos et souvenirs : journal visuel, partage optimisé, identification visuelle en cas de fugue

Fiches animales interactives : historiques, modules activés, IA dédiée

Tableau de bord personnalisable avec carte identité et widgets par module issus des modules activés

Animations de célébration et suggestions IA contextuelles

Notifications IA : rappels, alertes urgentes, suggestions intelligentes

Mode hors-ligne & synchronisation différée

Modules communautaires : alerte fugue, services entre utilisateurs, sphères (monnaie d'entraide)

🤖 IA intégrée au cœur du projet

IA locale : OCR, analyse comportementale, suggestions embarquées

IA cloud : apprentissage collectif, recommandations, statistiques anonymisées

IA maîtresse : centralise toutes les IA, optimise les ressources, personnalise l’expérience

Apprentissage autonome : plus il y a d’utilisateurs, plus l’IA devient intelligente

Pour un récapitulatif des pratiques IA (local-first, collecte de métriques, synchronisation offline, fonctionnalités premium), consultez [docs/ia_policy.md](docs/ia_policy.md).

🧱 Architecture modulaire

AniSphère fonctionne avec un noyau central auquel s’ajoutent des modules indépendants, activables selon les besoins :

Santé

Éducation

Dressage

Communauté

Fugue

Missions / professionnels

Chaque module embarque sa propre IA et son propre système de données.

**Services transverses du noyau** : messagerie (`lib/modules/messagerie/services/messaging_service.dart`), partage (`lib/modules/noyau/services/local_sharing_service.dart`), commande vocale (`lib/modules/voice/speech_recognition_service.dart`), notifications (`lib/modules/noyau/services/notification_service.dart`), exports (`lib/modules/noyau/services/share_history_service.dart`).

🔒 Sécurité et confidentialité



Stockage local par défaut (aucune donnée personnelle dans le cloud sans consentement)

Données chiffrées (local + synchronisation différée chiffrée)

Pas de publicité, pas de revente de données

Authentification sécurisée (Google, Apple, Email)

💡 Pourquoi AniSphère est unique ?

Tout est personnalisable (UI, modules, espèces…)

IA intégrée nativement, pas ajoutée après coup

Adaptée aux professionnels et associations avec suivi multi-animaux

Compatible avec une vie sans Internet, mais aussi avec du cloud intelligent

Pensée pour durer : chaque photo, chaque information contribue à enrichir votre carnet de suivi

📲 Statut actuel

Version alpha en développement

Tests automatisés en place

IA locale opérationnelle (OCR, suggestions, compression)

Noyau fonctionnel avec stockage hybride (Hive + Firebase différé)
ℹ️ Utilisation du module Partage
- En mode gratuit, ouvrez l’onglet **Partage** pour générer un QR code ou un fichier à envoyer manuellement.
- Avec l’abonnement Premium, activez la synchronisation cloud pour partager automatiquement vos données entre plusieurs appareils.

👨‍💻 Contribuer

AniSphère est un projet structuré, évolutif, ouvert à la contribution.
Le développement repose sur **Flutter 3.32.x** et **Dart 3.4+**.
Les workflows CI utilisent cette version : assurez-vous qu'elle
est installée localement avant de lancer les tests.

Documentation complète (voir README_DEV.md)

Tests automatisés intégrés

Modules indépendants faciles à ajouter (voir aussi `docs/suivi_superadmin.md` pour le module Superadmin)

Scripts d’automatisation prêts
🧪 Lancer les tests

Pour lancer les tests localement :
1. Copiez `assets/credentials.json.example` vers `assets/credentials.json`.
2. Exécutez `flutter test --coverage`.

Toutes les commandes de test se lancent depuis la racine du projet :
```bash
flutter pub get
flutter test --coverage
```
Les tests Firebase nécessitent de copier `assets/credentials.json.example` vers `assets/credentials.json`.
Ce fichier reste en dehors du suivi Git grâce à `.gitignore`. Gardez donc vos identifiants uniquement en local.
Pour plus de détails, consultez [README_Tests.md](README_Tests.md) et [docs/test_architecture.md](docs/test_architecture.md).

Rejoignez l’aventure et contribuez à créer la meilleure application de suivi animal !
© AniSphère 2025 — Suivez vos animaux comme jamais auparavant.
