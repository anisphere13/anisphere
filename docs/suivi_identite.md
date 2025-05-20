## Suivi de développement — Module Identité animale

Ce document suit le développement du module Identité animale pour AniSphère. Il est actif par défaut, gratuit, et constitue une base stratégique pour la sécurité, la personnalisation et la fiabilité du suivi animal. Ce module est conçu pour être 100 % fonctionnel hors ligne, avec synchronisation différée et OCR intégré.

### Statut : 
- [x] Cahier des charges validé
- [ ] Dossier `lib/modules/identite/` créé
- [ ] Modèle `identity_model.dart` défini
- [ ] Service `identity_service.dart` initialisé
- [ ] UI écran identité (consultation + édition) créé
- [ ] Intégration OCR documents (I-CAD, LOF, carnet papier)
- [ ] IA de validation photo (sélection + vérification automatique)
- [ ] Génération QR code identité + page publique
- [ ] Historique des modifications (propriétaire, statut…)
- [ ] Détection automatique des doublons
- [ ] Génération mini-carte PDF (format CB)
- [ ] Rappel IA annuel de mise à jour
- [ ] Ajout d’un statut juridique optionnel (chien d’assistance, etc.)
- [ ] Badge "Identité vérifiée" IA (photo + données cohérentes)
- [ ] Export passeport visuel (premium, désactivé pour l’instant)
- [ ] Tests unitaires (modèle, service, IA photo)
- [ ] Tests widget (fiche identité, édition, QR)
- [ ] Tests d’intégration (ajout + lecture + partage QR)

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

> Dernière mise à jour : [À compléter à chaque étape]

