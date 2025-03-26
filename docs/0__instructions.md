# 0- Instructions

| Section                                                                                                                                    | Détail                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|:-------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Section                                                                                                                                    | Détail                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| 1️⃣ Présentation Générale                                                                                                                   | 📌 AniSphère est une application modulaire pour le suivi des animaux, adaptée aux particuliers et aux professionnels. 🎯 Objectif : Suivi de la santé, du pistage, de l’entraînement et du bien-être animal via IA locale et cloud, suivi GPS et optimisation des coûts Firebase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Technologies principales                                                                                                                   | ✔ Flutter → Développement mobile (Android/iOS) et Web futur. ✔ Hive → Base locale pour limiter Firebase. ✔ Firebase → Authentification, Firestore, notifications. ✔ TensorFlow Lite → IA locale pour analyse comportementale et OCR. ✔ OpenCV → Analyse d’images et reconnaissance optique. ✔ Cloud Firestore & Firebase Storage → Stockage cloud optimisé. ✔ Ubuntu → Environnement de développement. 💡 Optimisation Firebase : Stockage principalement en local, Firestore uniquement si nécessaire, synchronisation différée pour réduire les coûts.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| 2️⃣ Noyau Central & Modules                                                                                                                 | 📌 Le noyau gère les fonctionnalités principales et la communication entre modules. ✔ Gestion des utilisateurs et des animaux ✔ Interconnexion entre modules ✔ Supervision de l’IA locale et cloud ✔ Optimisation du stockage (Hive & Firebase) ✔ Gestion centralisée des notifications et des permissions                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| Magasin de Modules                                                                                                                         | ✅ Modules indépendants et téléchargeables. ✅ Gestion des permissions pour limiter l’accès selon le profil utilisateur.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Fonctionnalités intégrées                                                                                                                  | ✔ OCR (factures, ordonnances vétérinaires) ✔ Compression des fichiers pour réduire la charge serveur ✔ Logs & historique des actions ✔ Mode hors-ligne & synchronisation différée                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| 💡 Pourquoi cette architecture ?                                                                                                           | ✔ Flexibilité (modules activables selon les besoins). ✔ Optimisation des performances (moins de charge inutile). ✔ Réduction des coûts Firebase. ✔ Expérience utilisateur fluide et unifiée.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| 3️⃣ Ergonomie & Interface                                                                                                                   | 📌 Inspirée de Samsung Health pour une navigation intuitive. ✔ 4 onglets fixes en bas : 1️⃣ Accueil → Tableau de bord dynamique. 2️⃣ Partage → Accès aux données partagées. 3️⃣ Magasin de Modules → Activation/désactivation des modules. 4️⃣ Mes Animaux → Profils des animaux avec suivi (santé, pistage, entraînement).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Améliorations UX                                                                                                                           | ✅ L’ordre des modules et l’affichage des infos s’adaptent automatiquement. ✅ Slide vers le haut → Accès rapide aux actions essentielles. ✅ Mode sombre et clair automatique selon l’heure.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 4️⃣ Organisation des Conversations                                                                                                          | 📌 Pour un suivi structuré du développement ✔ Conversation Générale → Décisions stratégiques & roadmap ✔ Une conversation par module → Développement détaillé et suivi des fonctionnalités ✔ Conversation Bugs & Tests → Rapports de bugs, corrections et améliorations                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| 💡 Pourquoi cette structure ?                                                                                                              | ✔ Chaque module est géré indépendamment ✔ La conversation générale garde une vue d’ensemble ✔ Les tests sont séparés du développement pour plus de clarté                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| 5️⃣ Suivi de Développement & Roadmap                                                                                                        | 📌 Le fichier "Suivi_AniSphere.ods" est la référence principale.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| Résumé des Feuilles du Suivi                                                                                                               | 0. Instructions → Informations globales sur le projet et directives principales. 1- Idees → Liste des nouvelles fonctionnalités et optimisations futures. 2- Roadmap → Plan des grandes étapes du projet et priorités. 3- Suivi des Tâches  → Liste détaillée des tâches en cours, leur statut et leur avancement.  4- Gestion des Collections → Structuration et suivi des éléments enregistrés dans l’application. 5- UX  → Principes d’ergonomie, navigation et expérience utilisateur d’AniSphère. 6- Technos par Module → Liste des technologies utilisées et leur attribution par module.  7- IA → Planification et structuration des intelligences artificielles du projet. 8- Modèle Éco → Stratégie de monétisation et gestion financière du projet. 9- Planification Photos → Organisation des médias et contenus visuels du projet. 10- Architecture → architecture modulaire claire et évolutive, facilitant la séparation des responsabilités, la maintenance, et l’activation des modules selon les besoins de l’utilisateur. |
| 6️⃣ Optimisation des Performances et Coûts                                                                                                  | 📌 Objectif : Réduction des coûts Firebase et optimisation de l’IA. ✔ Stockage local (Hive) priorisé ✔ Synchronisation Firebase différée pour limiter les accès ✔ Optimisation des requêtes Firestore ✔ Compression des fichiers avant envoi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| Suivi des performances                                                                                                                     | ✔ Firebase Analytics → Statistiques d’usage ✔ Datadog / Sentry → Suivi des performances ✔ Outils Flutter → Analyse des lenteurs                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| 7️⃣ Monétisation et Rentabilité                                                                                                             | 📌 Optimisation des revenus via abonnement et modules payants. ✔ Modules gratuits vs payants → Définition d’un modèle économique clair ✔ Abonnements personnalisés selon les profils utilisateurs ✔ Optimisation Firebase pour limiter les frais ✔ Mise en place d’une boutique interne                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| 💡 Stratégie de rentabilité rapide                                                                                                         | ✔ Offrir des fonctionnalités gratuites attractives ✔ Convertir les utilisateurs en abonnés payants via des options premium ✔ Limiter la charge serveur pour maximiser la marge                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 8️⃣ Stratégie de Mise à Jour et Versioning                                                                                                  | 📌 Gestion efficace des versions pour éviter la fragmentation. ✔ Mises à jour majeures → Ajout de nouvelles fonctionnalités ✔ Mises à jour mineures → Améliorations et corrections de bugs ✔ Patches correctifs → Corrections rapides sans modification de structure                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Déploiement                                                                                                                                | ✔ Mise à jour progressive via Firebase Remote Config ✔ Gestion des tests en pré-production avant publication ✔ Canal bêta pour testeurs avant mise en ligne générale                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| 9️⃣ Sécurité et Gestion des Accès                                                                                                           | 📌 Authentification et protection des données utilisateur. ✔ OAuth / Google Sign-in / Apple Sign-in → Accès sécurisé ✔ Chiffrement des données en local et sur Firebase ✔ Gestion avancée des permissions et rôles utilisateur                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 💡 Stratégie de sécurité avancée                                                                                                           | ✔ Contrôle strict des accès aux modules ✔ Protection contre les accès non autorisés ✔ Mises à jour régulières pour éviter les failles                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| 🔹 10️⃣ Interopérabilité et API                                                                                                             | 📌 Connexion aux systèmes vétérinaires et intégrations futures. ✔ Exportation des données de suivi santé et pistage ✔ Création d’API privée pour compatibilité avec d’autres applications                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| 💡 Objectif                                                                                                                                | ✔ Faciliter la collaboration avec vétérinaires et refuges ✔ Rendre AniSphère compatible avec d’autres systèmes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 🎯 Objectif : Développer rapidement l’application AniSphère, sans bugs, de manière modulaire, progressive et lisible, même pour un novice. | Méthode de travail intégrée avec ChatGPT + Copilot : 1- ChatGPT génère le code de la fonctionnalité demandée (fonction, widget, service)2- Tu colles le code à la fin du fichier concerné3- Copilot le détecte, le repositionne dans le bon bloc, complète les imports, ajuste la structure4- Tu exécutes ton script ./dev.sh → Build, analyse, test5- Tu valides ou corriges, puis tu ajoutes une tâche terminée dans ton tableau Notion ou ton tableur .ods6- Tu redemandes une nouvelle fonctionnalité à ChatGPT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |

---

## ✅ Prompt de Développement AniSphère – Version Complète & Professionnelle

### 🎯 Objectif global :
Assurer un développement **modulaire, rapide, auto-apprenant et intelligent**, avec :
- Une **architecture claire** et respectée
- Un **workflow fluide entre ChatGPT, Copilot et tests**
- Une **UX optimisée** inspirée de Samsung Health
- Une **IA hybride auto-apprenante locale/cloud**
- Un **suivi automatisé en `.md`** (plus de tableur)
- Une **stratégie Firebase éco-performante**

### 🧱 Structure modulaire à respecter

Pour le module `[[NOM DU MODULE]]`, tu créeras :

```
lib/modules/[[nom_module]]/
├── models/
├── services/
├── screens/
├── widgets/
├── logic/      # IA, OCR, traitement (facultatif)
├── tests/      # unit / widget / integration
```

Chaque fichier suit cette structure avec une **séparation stricte des responsabilités**.

### ⚙️ Méthode de travail recommandée

1️⃣ Étapes par fichier : me demander chaque fichier avant de coder. Ne générer que ce fichier.

2️⃣ Continuité propre : terminer par `"Fin de [[nom_du_fichier.dart]] – Reprendre à : [[étape suivante]]"`

3️⃣ Copilot : ajouter un prompt clair en haut du fichier pour guider Copilot.

4️⃣ Explication : où coller, à quoi ça sert, comment utiliser, dépendances.

5️⃣ Dépendances : commandes `flutter pub add`, modifications `pubspec.yaml`.

### ✅ Tests Automatisés

- À chaque fonctionnalité, proposer : `unit_test`, `widget_test`, `integration_test`
- Dossiers générés avec `generate_test_module.dart`
- Suivi dans `docs/test_tracker.md` via `update_test_tracker.dart`

### 🔁 GitHub Actions Automatisées

| Action | Fichier | Effet |
|--------|---------|-------|
| Tests auto | `.github/workflows/flutter_tests.yml` | Push sur `main`, `flutter test` |
| Tracker auto | `.github/workflows/update_test_tracker.yml` | Suivi tests dans `docs/` |
| Génération | `scripts/generate_test_module.dart` | 3 fichiers test/module |
| Markdown | `scripts/update_test_tracker.dart` | Génère `docs/test_tracker.md` |

### 🎨 UX AniSphère

- Navigation Samsung Health
- Slide Up → Actions rapides
- Notifications haut droite
- Modules activables
- UI adaptative (IA)
- Effets visuels, retour haptique
- Accessibilité poussée

### 💰 Optimisation Firebase

- Hive/SQLite par défaut
- Firestore = backup ou différé
- Compression, sync différée, `isSynced`, déclencheurs automatiques

### 🤖 IA Hybride Auto-apprenante

| Niveau | Local | Cloud |
|--------|-------|-------|
| Noyau  | Suivi, erreurs, IA base | IA globale |
| Module | Comportement, OCR | Suggestions IA |
| Santé  | OCR TFLite | IA cloud BigQuery |
→ Apprentissage actif pour tous, même sans abonnement.

### 📈 Monétisation

- IA cloud + modules premium
- Export PDF, traductions = micro-achat
- IA gratuite mais limitée sans abonnement

### ✅ Suivi Markdown

Docs mis à jour automatiquement :
- `docs/suivi_[module].md`
- Tests : `docs/test_tracker.md`

### ✨ Exemple lancement

> “Commence le module `Santé` :  
1. `health_record_model.dart`  
2. `health_service.dart`  
3. `health_form_screen.dart`”



---

## 🧱 Architecture du projet AniSphère


# 🔹 Architecture Modulaire AniSphère – Version 2025

AniSphère utilise une architecture **modulaire, propre et évolutive**, facilitant :
- La séparation claire des responsabilités
- Le développement progressif par module
- L'intégration d'IA locale/cloud
- Le suivi automatisé du développement et des tests

---

## 📁 Structure globale du projet

```
anisphere/
├── lib/
│   ├── modules/
│   │   └── noyau/
│   │       ├── models/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── services/
│   ├── screens/                      # Écrans globaux (non modulaires)
│   ├── services/                     # Services globaux (Firebase, Local, Init)
│   ├── firebase_options.dart
│   └── main.dart
│
├── test/
│   ├── global/
│   │   ├── integration/
│   │   ├── unit/
│   │   └── widget/
│   ├── noyau/
│   │   ├── integration/
│   │   ├── unit/
│   │   └── widget/
│   └── test_module_modele/
│       ├── integration/
│       ├── unit/
│       └── widget/
│
├── scripts/
│   ├── generate_test_module.dart
│   └── update_test_tracker.dart
│
├── docs/
│   ├── 0__instructions.md
│   ├── 1__idees.md
│   ├── 2__roadmap.md
│   ├── 3__suivi_taches.md
│   ├── 4__gestion_des_collections.md
│   ├── 5__ux.md
│   ├── 6__technos_par_module.md
│   ├── 7__ia.md
│   ├── 8__modèle_éco.md
│   ├── 9__planification_photos.md
│   ├── 10__architecture.md
│   └── test_tracker.md
│
├── .github/workflows/
│   ├── flutter_tests.yml
│   └── update_test_tracker.yml

├── pubspec.yaml
├── README.md
├── README_DEV.md
└── sync.sh
```

---

## ✅ Règles de structuration

- Tous les modules sont dans `lib/modules/[nom_module]/`
- Le **noyau** est un module comme les autres (`modules/noyau`)
- Chaque module a ses propres :
  - `models/`
  - `screens/`
  - `services/`
  - `providers/`
  - `logic/` (facultatif : IA, OCR, traitement)
  - `tests/` (reliés à `test/[nom_module]/`)
- Les services partagés (auth, Firebase, Hive) sont dans `lib/services/`

---

## 🧪 Tests automatisés

- Chaque module possède un dossier `test/[module]/` avec :
  - `unit/` – logique métier
  - `widget/` – interface Flutter
  - `integration/` – ensemble complet
- Génération automatique :
```bash
dart run scripts/generate_test_module.dart
```
- Suivi automatique dans `docs/test_tracker.md` :
```bash
dart run scripts/update_test_tracker.dart
```

---

## ⚙️ CI/CD et automatisation

- Tests lancés à chaque push :
  `.github/workflows/flutter_tests.yml`
- Suivi Markdown mis à jour :
  `.github/workflows/update_test_tracker.yml`

---

## 💡 Avantages

- Architecture claire et modulaire
- Intégration parfaite avec GitHub Copilot
- Suivi automatique en `.md`
- IA hybride facilement activable
- Monétisation intégrée module par module
- Maintenance facilitée sur le long terme
