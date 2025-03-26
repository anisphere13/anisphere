# 🐾 AniSphère 2.0

AniSphère est une application modulaire intelligente dédiée au **suivi global des animaux**, conçue pour les particuliers comme les professionnels.

> 📱 **Suivi santé**, 🧭 **pistage GPS**, 🎓 **éducation**, 🤖 **IA comportementale**, et bien plus…
> 🧠 Développée avec **Flutter**, **Firebase**, **Hive**, et optimisée avec **ChatGPT + GitHub Copilot**.

---

## 🎯 Objectifs

- Offrir un **suivi complet** (santé, comportement, alimentation, activités)
- Permettre l’ajout de **modules personnalisés** à la demande
- Utiliser une **IA hybride (locale + cloud)** pour des analyses puissantes
- Optimiser les **coûts Firebase** avec synchronisation différée
- Garantir une **expérience offline-first** grâce à Hive

---

## 🧩 Architecture modulaire

Chaque module est autonome et activable selon les besoins :
- 📁 `modules/sante` → Carnet vétérinaire, traitements, vaccins
- 📁 `modules/pistage` → Localisation, historique des déplacements
- 📁 `modules/education` → Socialisation, apprentissage, exercices
- 📁 `modules/communauté` → Partage, missions, garde, entraide

Le tout relié à un **Noyau central** qui gère :
- Authentification, IA maîtresse, stockage local/cloud, notifications, etc.

---

## 🚀 Technologies utilisées

| Domaine            | Stack Technique                         |
|--------------------|------------------------------------------|
| Développement      | Flutter (Android / iOS / Web)            |
| Stockage local     | Hive                                     |
| Cloud & Realtime   | Firebase Firestore, Storage, Auth        |
| IA locale          | TensorFlow Lite, OpenCV                  |
| OCR                | Tesseract / Modèle IA interne            |
| Backend optionnel  | Firebase Functions (léger)               |
| Site web compagnon | Connecté à l’App (UniSphère)             |

---

## 🗂️ Structure du projet

```
anisphere/
├── lib/
│   ├── models/             # Modèles de données
│   ├── providers/          # État global avec Provider
│   ├── screens/            # Écrans de navigation
│   ├── services/           # Hive, Firebase, IA...
│   └── modules/            # Modules activables
├── docs/                   # Suivi Markdown (projet et modules)
├── test/                   # Tests unitaires (en cours)
├── scripts/                # Scripts (sync, build, tests)
├── sync.sh                 # Script de sauvegarde Git
└── README.md               # Ce fichier
```

---

## 📌 Suivi & Documentation

Le projet est suivi avec des fichiers Markdown dans [`/docs/`](docs/) :

- `0__instructions.md` → Présentation & directives globales
- `1__idees.md` → Idées futures & modules à venir
- `2__roadmap.md` → Étapes majeures de développement
- `3__suivi_taches.md` → Suivi des tâches
- `6__technos_par_module.md` → Technologies utilisées par module
- `10__architecture.md` → Arborescence et organisation technique

---

## 🔐 Sécurité & Confidentialité

- Authentification sécurisée : Email / Google / Apple
- Données locales chiffrées
- Données sensibles non exposées dans le cloud
- Permissions avancées selon profil & module actif

---

## 🤖 IA Hybride

- **IA locale** : comportement animal, OCR, prédiction
- **IA cloud** : analyses de santé, recommandations vétérinaires
- **IA maîtresse** : optimisation Firebase, personnalisation modules

---

## 🛠️ Lancer le projet localement

```bash
flutter pub get
flutter run
```

---

## 🔧 Déploiement & Tests

- `./sync.sh` → push Git rapide
- Tests unitaires en cours dans `/test/`
- Déploiement via Firebase et GitHub Actions à venir

---

## 💬 Contact & Contribution

Projet maintenu par **@anisphere13**
📍 https://github.com/anisphere13/anisphere

> Contributions, idées et retours bienvenus (voir `docs/1__idees.md`)

---

## 🧠 Méthodologie

Le projet suit une logique **développement + IA assistée** :

1. Code généré ou guidé par ChatGPT
2. Optimisé automatiquement avec GitHub Copilot
3. Sauvegarde sur GitHub via script personnalisé
4. Suivi Markdown et organisation modulaire
