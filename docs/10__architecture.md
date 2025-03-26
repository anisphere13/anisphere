
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
