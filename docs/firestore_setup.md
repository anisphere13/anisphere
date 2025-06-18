# 🚀 Configuration initiale de Firestore

Ce guide résume les étapes manuelles à effectuer dans la console Firebase avant le premier lancement d'AniSphère. Il complète la structure détaillée dans [docs/4__gestion_des_collections.md](docs/4__gestion_des_collections.md).

## Collections à créer manuellement

1. **`ia_categories/`**
   - `sante/uploads`
   - `sante/models`
   - `sante/feedbacks`
   - `education/uploads`
   - `education/models`
   - `education/feedbacks`
   - `dressage/uploads`
   - `dressage/models`
   - `dressage/feedbacks`
   - `communaute/uploads`
   - `communaute/models`
   - `communaute/feedbacks`
2. **`logs_ia/`**
   - `sante`
   - `education`
   - `dressage`
   - `communaute`
3. **`consents/`**
   - document `global` avec les champs :
     - `current_version` (number)
     - `last_update` (timestamp)
     - `description` (string)
     - `required` (bool)
4. **`superadmin/`**
   - document `flags` contenant :
     - `start_training_sante` (bool)
     - `start_training_education` (bool)
     - `start_training_dressage` (bool)
     - `start_training_communaute` (bool)

## Vérification et scripts d'initialisation

Après avoir créé ces collections, exécutez :

```bash
flutter pub run scripts/firestore_verification.dart
```

Le script vérifie la présence des documents et affiche les éléments manquants. Corrigez la configuration si nécessaire puis relancez-le.
