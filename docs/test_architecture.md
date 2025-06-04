# 📚 Architecture complète des tests

Cette documentation détaille la structure complète des tests pour AniSphère, leur emplacement et la manière de les utiliser. Elle complète `README_Tests.md` avec une vue globale module par module.

## 1. Organisation générale

- Tous les tests sont regroupés dans le dossier `test/` à la racine.
- Chaque module possède un sous-dossier dédié : `test/<nom_du_module>/`.
- À l’intérieur de chaque module, on retrouve trois catégories :
  - `unit/` → tests unitaires (modèles, services, logique)
  - `widget/` → tests de widgets Flutter
  - `integration/` → scénarios utilisateur complets
- La structure du dossier `test/` reflète celle de `lib/` pour garder une correspondance directe entre code et tests.

Exemple pour le module Identité :
```
test/
└── identite/
    ├── unit/
    ├── widget/
    └── integration/
```

## 2. Liste initiale des dossiers

| Module | Dossier de tests |
|-------|-----------------|
| noyau | `test/noyau/` |
| identite | `test/identite/` |
| (à venir) santé | `test/sante/` |
| (à venir) education | `test/education/` |
| (à venir) dressage | `test/dressage/` |
| (à venir) communaute | `test/communaute/` |

Lorsqu’un nouveau module est créé, on lance `dart run scripts/generate_test_module.dart <nom>` pour générer automatiquement la hiérarchie.

## 3. Fichiers clés

- `test/test_config.dart` : initialise l’environnement Flutter et Firebase pour les tests.
- `scripts/generate_test_module.dart` : création rapide des dossiers et fichiers de base pour un module de test.
- `scripts/update_test_tracker.dart` : met à jour `docs/test_tracker.md` avec l’état des tests présents ou manquants.
- `.github/workflows/flutter_tests.yml` : exécute `flutter test --coverage` à chaque push ou Pull Request.
- `.github/workflows/update_test_tracker.yml` : met à jour `docs/test_tracker.md` automatiquement après exécution des tests.

## 4. Exécution locale

1. Installer Flutter (version indiquée dans `.github/workflows/flutter_tests.yml`).
2. Lancer `flutter pub get` pour récupérer les dépendances.
3. Générer les mocks si nécessaire :
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. Lancer les tests :
   ```bash
   flutter test --coverage
   ```
5. Exécuter `dart scripts/update_test_tracker.dart` pour mettre à jour le suivi local.

## 5. Intégration GitHub

- Les workflows présents dans `.github/workflows/` effectuent automatiquement les étapes ci-dessus.
- Les rapports de couverture sont accessibles directement depuis les actions GitHub.
- `update_test_tracker.yml` commite le fichier `docs/test_tracker.md` pour conserver l’historique.

## 6. Connexion à l’IA

Les résultats de test et les rapports de couverture alimentent l’IA maîtresse :

1. `docs/test_tracker.md` est analysé par l’IA afin de détecter les zones sans tests ou les erreurs fréquentes.
2. Les logs de GitHub Actions (succès ou échecs) sont collectés par l’IA cloud pour identifier les bugs récurrents.
3. À terme, l’IA proposera automatiquement des correctifs ou des squelettes de tests manquants dans `generate_test_module.dart`.
4. Les modules où les tests échouent souvent seront signalés dans `docs/noyau_suivi.md` pour prioriser les corrections.

## 7. Préparation aux correctifs automatiques

- Les échecs de test fréquents sont enregistrés et serviront d’exemples pour entraîner l’IA locale à proposer des correctifs simples (hotfix IA).
- Une section « Bugs récurrents » sera ajoutée dans `docs/noyau_suivi.md` pour suivre leur résolution.

## 8. Réplication de l’environnement

Pour travailler en local :

1. Cloner le dépôt GitHub :
   ```bash
   git clone <repo-url>
   ```
2. S’assurer d’avoir les versions de Flutter/Dart compatibles (voir `pubspec.yaml`).
3. Copier `assets/credentials.json.example` vers `assets/credentials.json` si nécessaire pour les tests Firebase.
4. Lancer les tests comme indiqué plus haut.

Sur GitHub, rien à configurer : les workflows CI se déclenchent automatiquement.

---

Cette architecture garantit des tests cohérents, exploitables par l’IA et faciles à maintenir pour chaque module d’AniSphère.