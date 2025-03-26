# 🐾 AniSphère 2.0 – README DE DÉVELOPPEMENT (NON PUBLIC)

Ce fichier est destiné à un usage **interne uniquement**. Il explique la **méthodologie complète de développement** du projet AniSphère, avec des consignes pour ChatGPT, GitHub Copilot, et toute personne ou IA impliquée dans le projet.

---

## 🎯 Objectif global

- Développer AniSphère de manière **modulaire**, **progressive**, et **lisible**.
- Utiliser une **IA hybride (locale + cloud)** pour optimiser les performances et les coûts Firebase.
- Permettre à un développeur **novice** de progresser étape par étape, sans se perdre.

---

## 🔧 Technologies principales (extrait de `0__instructions.md`)

- **Flutter** → Développement Android/iOS/Web
- **Hive** → Base locale pour usage offline
- **Firebase** → Auth, Firestore, Storage, FCM
- **TensorFlow Lite** → IA locale (comportement/OCR)
- **OpenCV** → Vision et analyse d’image
- **Ubuntu** → Environnement de développement

---

## 🧱 Structure technique (extrait de `10__architecture.md`)

```
lib/
├── main.dart
├── firebase_options.dart
├── services/              # Firebase, Hive, Auth, IA
├── providers/             # Providers globaux
├── modules/               # Modules (sante, education, etc.)
│   ├── [nom_du_module]/
│   │   ├── models/
│   │   ├── screens/
│   │   ├── services/
│   │   ├── providers/
│   │   └── tests/
docs/                      # Fichiers de suivi Markdown
scripts/                   # Scripts (sync, tests, etc.)
README.md                  # Public
README_DEV.md              # Ce fichier
```

---

## 🚀 Routine de développement (exécutée à chaque fonctionnalité)

1. Je choisis une tâche dans `/docs/module_xx.md`
2. Je demande le code à ChatGPT (fonction, widget, service, etc.)
3. Je colle le code en bas du fichier concerné
4. Je demande à Copilot de l’optimiser et le replacer automatiquement
5. Je teste avec `./dev.sh`
6. Je mets à jour la tâche dans `/docs/module_xx.md` ou `3__suivi_taches.md`
7. Je fais un `./sync.sh` pour commit/push automatiquement

---

## 🤖 Instructions pour ChatGPT

- Toujours générer du code **modulaire**, avec **explication claire**
- À la fin de chaque bloc, indiquer :
  - Où le coller
  - À quoi il sert
  - Quoi tester ensuite
- Ne jamais répéter le code déjà généré
- À chaque étape, proposer un prompt Copilot optimisé

---

## 🤖 Instructions pour GitHub Copilot

- Lire le fichier en cours et proposer une structure cohérente
- Compléter les blocs de code en s’appuyant sur :
  - Le fichier `.md` du module
  - Les classes/models déjà présents dans le projet
- Optimiser automatiquement l'import, le placement et la cohérence
- Générer des tests unitaires simples à partir des services et modèles

---

## 🛠️ Tests & Scripts

- Chaque module a son propre dossier `/tests/`
- Un script `./dev.sh` (build + analyze + test) est utilisé
- Un script `./sync.sh` push automatiquement vers GitHub

---

## 🔐 Spécificités internes

- 🔄 **Firebase est secondaire** → stockage prioritaire local via Hive
- 📡 Synchronisation cloud différée
- 📦 Compression automatique des fichiers (OCR, photos, etc.)
- 🔐 Aucune donnée sensible (nom, numéro, etc.) ne remonte au cloud

---

## 📁 Références de suivi (fichiers Markdown)

Tous les fichiers de suivi se trouvent dans `/docs/` :
- `0__instructions.md` → Vue globale du projet
- `1__idees.md` → Fonctionnalités à venir
- `2__roadmap.md` → Étapes stratégiques
- `3__suivi_taches.md` → Tâches en cours / terminées
- `6__technos_par_module.md` → Technologies par module
- `10__architecture.md` → Structure modulaire de l’app

---

## 🧠 Méthodologie globale

> "Développer comme un jeu de rôle"

- ✅ Chaque module est une mini mission
- ✅ Chaque fonctionnalité est une sous-quête
- ✅ Le développeur est guidé, sans surcharge
- ✅ Le suivi `.md` permet de visualiser l’avancement
- ✅ ChatGPT + Copilot servent de mentors

---

Ce fichier ne doit **pas être affiché publiquement**. Il est réservé au développement et au suivi local du projet.
