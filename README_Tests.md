# ✅ README — Tests Automatisés & Suivi de Développement AniSphère

Ce dossier centralise **tous les outils, scripts, conventions et workflows** utilisés pour assurer un suivi rigoureux, automatisé et évolutif du développement de l’application **AniSphère**.

---

## 📁 Structure standard des tests

Chaque module (y compris le **noyau**) doit avoir la structure suivante dans le dossier `/test/` :

```
test/
  noyau/
    unit/
    widget/
    integration/
  modules/
    [nom_module]/
      unit/
      widget/
      integration/
```

**Définitions :**
- `unit/` : Tests de modèles, services, logique métier pure.
- `widget/` : Tests d’affichage, interaction, états UI.
- `integration/` : Tests de parcours utilisateur, navigation, stockage, etc.

---

## 🧪 Obligations de test par fonctionnalité

| Type | Exemple | Test requis |
|------|---------|-------------|
| Modèle | `animal_model.dart` | ✅ unitaire (structure, sérialisation) |
| Service | `user_service.dart` | ✅ unitaire (logique, mocks) |
| Écran UI | `login_screen.dart` | ✅ widget |
| Navigation | `main_screen.dart → animal_screen.dart` | ✅ intégration |
| Notification | `notification_service.dart` | ✅ unitaire + intégration |
| Connexion | `auth_service.dart` | ✅ widget + intégration (email/Google/Apple + erreurs) |
| IA / API | `photo_verification_service.dart` | ✅ unitaire avec mocks |
| UX critique | `splash_screen.dart` | ✅ widget + manuel (fluidité, offline, erreurs) |

---

## ⚙️ Scripts intégrés

| Script | Rôle |
|--------|------|
| `scripts/generate_test_module.dart` | Crée l’ossature complète de tests pour un module |
| `scripts/update_test_tracker.dart` | Met à jour automatiquement `docs/test_tracker.md` |
| `scripts/update_noyau_suivi.dart` | Met à jour `docs/noyau_suivi.md` après chaque fichier |
| `scripts/update_suivi_taches.dart` | Met à jour `docs/3__suivi_taches.md` automatiquement |

---

## 🔁 Workflows GitHub Actions

Déclenchés à chaque push ou merge :

- **`flutter_tests.yml`** : Exécute tous les tests Flutter et produit un rapport de couverture.
- **`update_test_tracker.yml`** : Analyse tous les fichiers modifiés, détecte les oublis de tests, et met à jour `test_tracker.md`.

> Tous les workflows se trouvent dans `.github/workflows/`.

---

## 🧠 Suggestions IA — à venir

Des fonctions avancées sont prévues pour automatiser encore plus :

- Analyse des fichiers non couverts par des tests.
- Génération automatique de tests via IA (logique + mocks).
- Détection de logique complexe à sécuriser par tests.
- Correction intelligente + proposition de refactoring.

---

## 📝 Bonnes pratiques manuelles

- Tout fichier `.dart` modifié **sans test associé** doit comporter un `// TODO: ajouter test`.
- Ce commentaire est automatiquement détecté et listé dans `docs/test_tracker.md`.
- Une convention de nommage stricte est appliquée (ex. : `nom_model_test.dart`, `nom_service_test.dart`, etc.).

---

## 🧩 Modules testables dès la création

Chaque nouveau module doit intégrer **dès le départ** :

- Un modèle de données (`model/`) avec test de sérialisation.
- Un service logique (`services/`) avec test unitaire.
- Une UI (`screen/`, `widgets/`) avec test widget simple.
- Un script `generate_test_module.dart` à exécuter dès la création.
- Un suivi dans `docs/suivi_[nom_module].md` avec état des tests.

> Cf. `docs/prompts_naturels.md` pour lancer un module proprement avec tests automatisés.

---

## 📚 Documentation liée

| Fichier | Contenu |
|--------|---------|
| `docs/test_tracker.md` | Suivi automatisé de la couverture de tests |
| `docs/10__architecture.md` | Structure de l’application et des tests |
| `docs/prompts_naturels.md` | Prompts ChatGPT pour structurer les modules et leurs tests |
| `README_DEV.md` | Vue complète pour les contributeurs |
| `README.md` | Présentation publique de l’app |

---

## ✅ Pour lancer tous les tests :

```bash
flutter test
```

Ou pour une catégorie :

```bash
flutter test test/noyau/unit/
flutter test test/modules/sante/widget/
```

---

> Besoin d’un exemple complet de structure de test pour un module ? Lance la commande :
```
dart scripts/generate_test_module.dart --module [nom]
```

---

📌 **AniSphère est conçu pour que chaque module soit testable, maintenable, évolutif. Les tests sont une brique centrale du projet.**
