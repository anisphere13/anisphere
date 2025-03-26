# anisphere

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# 🐾 AniSphère 2.0

AniSphère est une application modulaire pour le **suivi intelligent des animaux**, adaptée aux particuliers et aux professionnels.

## 🎯 Objectifs du projet

- Assurer un **suivi santé, bien-être, éducation et mission** des animaux.
- Proposer des **modules activables à la demande** (carnet vétérinaire, pistage, pharmacie...).
- Intégrer une **IA hybride locale/cloud** pour l’analyse comportementale et la réduction des coûts Firebase.
- Rendre l’application **offline-first** grâce à Hive, avec une synchronisation Firebase différée.

---

## 🧩 Architecture modulaire

Le projet est organisé par modules :
- Chaque module est **indépendant**, avec sa propre IA et logique métier.
- Tous les modules sont connectés au **Noyau Central** (authentification, IA maîtresse, stockage, interface).
- Voir le dossier [`/docs/modules/`](docs/modules/) pour le détail des modules.

---

## 🚀 Technologies utilisées

| Composant        | Technologie                     |
|------------------|---------------------------------|
| Application      | Flutter (Android / iOS / Web)   |
| Stockage local   | Hive                            |
| Stockage distant | Firebase Firestore / Storage    |
| IA locale        | TensorFlow Lite + OpenCV        |
| OCR              | Tesseract / IA personnalisée    |
| Site web         | Connecté au Noyau               |
| Backend (léger)  | Firebase Functions (optionnel)  |

---

## 🗂️ Structure du projet

```
lib/
├── models/             # Données (utilisateurs, animaux, etc.)
├── providers/          # État global (Provider)
├── screens/            # Interfaces utilisateurs
├── services/           # Firebase, Hive, Auth, IA, etc.
├── modules/            # Dossier modulaire par fonctionnalité
docs/                   # Suivi du projet (Markdown par feuille/module)
sync.sh                 # Script de sauvegarde GitHub
README.md               # Ce fichier
```

---

## ✅ Suivi de développement

Tout le suivi est centralisé dans le dossier [`/docs/`](docs/) :

- [Instructions globales](docs/0__instructions.md)
- [Idées et fonctionnalités futures](docs/1__idees.md)
- [Roadmap](docs/2__roadmap.md)
- [Suivi des tâches](docs/3__suivi_taches.md)
- [Modules](docs/6__technos_par_module.md)

---

## 🔐 Sécurité & Confidentialité

- Authentification : Google, Apple, Email
- Données sensibles chiffrées
- Stockage local prioritaire (Hive)
- Firebase réduit au minimum

---

## 🤖 IA Hybride

- Analyse comportementale en local (TensorFlow Lite)
- Analyse santé & OCR avec cloud ou local selon ressources
- IA maîtresse pour **réduction des coûts Firebase** + personnalisation

---

## 🛠️ Lancer le projet localement

```
flutter pub get
flutter run
```

---

## 📦 Déploiement & Tests

- Scripts automatisés à venir (`/scripts/`)
- Tests unitaires dans `/test/`
- Synchro Git avec `./sync.sh`

---

## 💬 Contact

Projet maintenu par **@anisphere13**  
GitHub : https://github.com/anisphere13/anisphere

---

> 🧠 Ce projet est développé étape par étape avec l’aide de ChatGPT, GitHub Copilot et un système de suivi Markdown.