## Suivi de développement — Module Identité animale

Ce document suit le développement du module Identité animale pour AniSphère. Il est actif par défaut, gratuit, et constitue une base stratégique pour la sécurité, la personnalisation et la fiabilité du suivi animal. Ce module est conçu pour être 100 % fonctionnel hors ligne, avec synchronisation différée et OCR intégré.

### Statut : 
- [x] Cahier des charges validé
- [x] Dossier `lib/modules/identite/` créé
- [x] Modèle `identity_model.dart` défini
- [x] Service `identity_service.dart` initialisé
- [x] UI écran identité (consultation + édition) créé
- [x] Intégration OCR documents (I-CAD, LOF, carnet papier)
- [x] IA de validation photo (sélection + vérification automatique)
- [x] Génération QR code identité + page publique
- [x] Historique des modifications (propriétaire, statut…)
- [ ] Détection automatique des doublons (en cours)
- [x] Génération mini-carte PDF (format CB)
- [x] Rappel IA annuel de mise à jour
- [x] Ajout d’un statut juridique optionnel (chien d’assistance, etc.)
- [x] Badge "Identité vérifiée" IA (photo + données cohérentes)
- [x] Export passeport visuel (premium, désactivé pour l’instant)
- [x] Tests unitaires (modèle, service, IA photo)
- [x] Tests widget (fiche identité, édition, QR)
- [x] Tests d’intégration (ajout + lecture + partage QR)
- - -
- **Généalogie**
- [x] Dossier `lib/modules/identite/` créé
- [x] Modèle `genealogy_model.dart` défini
- [x] Service `genealogy_service.dart` initialisé
- [x] Écran `genealogy_screen.dart` créé
- [x] Export de l’arbre généalogique (PDF/PNG)
- [x] Partage public du pedigree (QR / lien)

### Technologies utilisées
- Flutter, Hive, Firebase, qr_flutter
- Tesseract OCR, TFLite, OpenCV
- flutter_secure_storage, pdf

### Intégration au noyau
- Accès depuis l’écran "Mes Animaux"
- Activation IA maîtresse pour cohérence et suggestions
- Lien direct avec les modules Santé / Fugue / Communauté

### Objectif :
Assurer à chaque animal une fiche unique, fiable, partageable et intelligente, avec OCR, IA, QR code, historique et compatibilité complète AniSphère.

> Dernière mise à jour : 2025-06-21
### ✅ identity_model.dart
- 📁 `lib/modules/identite/models/identity_model.dart`
- Modèle complet de fiche identité animale (puce, statut, photo, historique, QR)
- Compatible Hive + Firebase, prêt pour IA photo et vérification automatique
- Test unitaire de sérialisation/desérialisation inclus
- 2025-06-21 : Ajout des champs éleveur (`breederName`, `breederEmail`, `breederPhone`) et mise à jour des tests
- Date : 2025-05-20

### ✅ identity_service.dart
- 📁 `lib/modules/identite/services/identity_service.dart`
- Service complet pour sauvegarde, historique, synchronisation cloud et MAJ des fiches d'identité
- Préparé pour Firebase + Hive, test unitaire simple inclus
- Date : 2025-05-20

### ✅ identity_screen.dart
- 📁 `lib/modules/identite/screens/identity_screen.dart`
- Écran de consultation/édition de l’identité : puce, statut, sauvegarde locale
- Préparé pour extension QR, IA, partage public
- Test widget minimal validant affichage des champs
- Date : 2025-05-20

### ✅ ocr_icad_service.dart
- 📁 `lib/modules/identite/services/ocr_icad_service.dart`
- Service OCR (Tesseract/MLKit) pour extraction de données sur documents I-CAD/LOF
- Expressions régulières incluses pour puce, nom, race, date
- Test unitaire sur RegEx validé
- Date : 2025-05-20

### ✅ photo_verification_service.dart
- 📁 `lib/modules/identite/services/photo_verification_service.dart`
- Service IA local pour scorer automatiquement les photos d’identité animale
- Détection simplifiée de netteté (Laplace) et centrage
- Test unitaire des scores logique inclus
- Date : 2025-05-20

### ✅ qr_generator_service.dart
- 📁 `lib/modules/identite/services/qr_generator_service.dart`
- Génère un QR code vers une page publique Firebase (I-CAD, statut, photo…)
- Widget `QrImageView` intégré pour affichage dans l’app
- Test de validation d’URL publique inclus
- Date : 2025-05-20

### ✅ identity_card_generator.dart
- 📁 `lib/modules/identite/services/identity_card_generator.dart`
- Génère une mini-carte PDF format CB avec photo, puce, statut, QR code
- Exportable localement ou imprimable, test PDF basique inclus
- Date : 2025-05-20

### ✅ identity_reminder_service.dart
- 📁 `lib/modules/identite/services/identity_reminder_service.dart`
- Déclenche une alerte IA si la fiche identité n’a pas été mise à jour depuis plus de 12 mois
- Connecté à `IAMaster`, testé avec un FakeIAMaster
- Date : 2025-05-20

### ✅ legal_status_service.dart
- 📁 `lib/modules/identite/services/legal_status_service.dart`
- Gère la déclaration du statut juridique (chien d’assistance, élevage…)
- Met à jour l’historique et sauvegarde via IdentityService
- Test unitaire avec service mocké
- Date : 2025-05-20

### ✅ identity_verification_service.dart
- 📁 `lib/modules/identite/services/identity_verification_service.dart`
- Vérifie automatiquement l’identité si photo nette + puce + statut
- Active le badge IA “Identité vérifiée”
- Test unitaire avec mocks des services
- Date : 2025-05-20

### ✅ identity_passport_generator.dart
- 📁 `lib/modules/identite/services/identity_passport_generator.dart`
- Génère un PDF premium stylisé multilingue pour fiche identité complète
- Exportable, partageable, réservé aux comptes premium (désactivé par défaut)
- Test PDF validé sans photo
- Date : 2025-05-20

### ✅ animal_screen.dart (bouton Identité)
- 📁 `lib/modules/noyau/screens/animal_screen.dart`
- Ajoute un bouton stylisé “Identité” redirigeant vers `IdentityScreen`
- Liaison complète avec `IdentityService` + Hive local
- UX cohérente avec le thème AniSphère
- Date : 2025-05-20

### ✅ animal_screen.dart (intégration complète)
- 📁 `lib/modules/noyau/screens/animal_screen.dart`
- Intègre le bouton “Identité” stylisé, relié à `IdentityScreen` + Hive
- UX Samsung Health / branding bleu nuit appliqué
- Préparé pour intégrer `AnimalModel` complet
- Date : 2025-05-20

### ✅ animal_screen.dart (finalisé avec AnimalModel)
- 📁 `lib/modules/noyau/screens/animal_screen.dart`
- Utilise le vrai `AnimalModel` pour afficher les données
- Redirige vers `IdentityScreen` via `IdentityService` Hive
- UX fluide, couleurs branding appliquées, navigation fonctionnelle
- Date : 2025-05-20

### ✅ genealogy_model.dart
- 📁 `lib/modules/identite/models/genealogy_model.dart`
- Modèle complet de généalogie (affixe, numéro de portée, LOF, mise à jour)
- Compatible Hive et conversion map via `GenealogyMapper`
- Date : 2025-05-20

### ✅ genealogy_service.dart
- 📁 `lib/modules/identite/services/genealogy_service.dart`
- Sauvegarde locale des noeuds et récupération rapide
- Synchronisation différée prévue
- Date : 2025-05-20

### ✅ genealogy_screen.dart
- 📁 `lib/modules/identite/screens/genealogy_screen.dart`
- Écran simple listant l'arbre (placeholder)
- Accès depuis la fiche identité via un bouton
- Date : 2025-05-20

### ✅ genealogy_ocr_service.dart
- 📁 `lib/modules/identite/services/genealogy_ocr_service.dart`
- Extrait automatiquement père et mère depuis un document (MLKit)
- Fonction `parseText` testée pour isoler les identifiants
- Date : 2025-05-20

### ✅ genealogy_summary_card.dart
- 📁 `lib/modules/identite/widgets/genealogy_summary_card.dart`
- Widget affichant les informations principales de généalogie
- Utilisé dans `GenealogyScreen`, test widget validé
- Date : 2025-05-20

### ✅ modules_screen.dart (accès Identité)
- 📁 `lib/modules/noyau/screens/modules_screen.dart`
- Ajout d'une section "Communauté" avec le module Identité activable
- Navigation directe vers `IdentityScreen`
- Date : 2025-06-21

### ✅ module_card.dart
- 📁 `lib/modules/noyau/widgets/module_card.dart`
- Carte cliquable ouvrant l'écran du module sélectionné (Identité compris)
- Date : 2025-06-21

### ✅ Localisations Identity
- 📁 `lib/l10n/app_xx.arb`
- Nouvelles clés `identityModuleTitle` et `identityModuleDescription` pour toutes les langues
- Ajout des clés `ai_score`, `breeder_*`, `onboarding_*`, `duplicate_*`, `photo_timeline_title`
- Date : 2025-06-21

