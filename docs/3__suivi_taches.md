✅ 3__suivi_taches.md — Tableau de bord global AniSphère

Ce fichier est une vue d’ensemble condensée du projet AniSphère. Il permet de suivre l’évolution par grandes étapes (noyau + modules) sans entrer dans les détails techniques. Chaque module dispose de son propre fichier de suivi détaillé. Ce tableau sert à suivre le cap général du développement.

⚠️ Ce fichier sera mis à jour automatiquement à chaque avancement significatif via les outils internes (sync_docs.sh, update_tracker, etc.)

- [ ] Créer les `*SummaryCard` pour chaque module actif (santé, dressage, éducation, communauté, etc.) à afficher dans `home_screen.dart`


🔰 Statut actuel

Phase actuelle : Développement du noyau

Modules encore inactifs (préparation uniquement)

Tests auto et CI/CD en structuration

🧩 Noyau central — Suivi global

Authentification : terminée (email / Google / Apple avec Hive local)

Reconnexion hors-ligne : terminée (stockage local actif hors connexion)

Gestion utilisateur : terminée (création, édition, rôles, stockage cloud/local)

IA maîtresse : en cours (compression, coût Firebase, pilotage auto)

Stockage hybride : terminé (Hive + Firebase avec sync différée)

Notifications globales : à venir (IA + catégories par module)

🩺 Santé — Activation prévue (Roadmap Phase 4)

OCR carnet santé : prévu (lecture ordonnances, vaccins)

Rappels traitements : prévu (notifications intelligentes)

Statistiques santé : prévu (suivi par IA)

Export PDF multilingue : prévu (partage professionnel)

🧠 Éducation — Activation prévue (Roadmap Phase 4)

Base d’exercices : prévu (techniques éducatives classées)

IA éducative : prévu (suggestions personnalisées)

Suivi progression : prévu (courbes + validation)

Playlist sonore : prévu (sons de socialisation)

🐾 Dressage — En attente d’activation

Pistage GPS : prévu (traces, historique, IA parcours)

Concours & agility : prévu (préparation + scoring)

Détection objets : prévu (entraînement au flair)

👥 Communauté — Phase préparatoire

Système de Sphères : prototype en cours (monnaie d’échange & entraide)

Profils publics : prévu (carte interactive, filtres)

Historique des échanges : prévu (réputation, avis)

🧪 Tests & Automatisation — En parallèle

Dossier de test propre : terminé (base unifiée propre)

Générateur de tests : terminé (script modulaire automatique)

Tracker de tests : terminé (fichier + mise à jour auto)

GitHub Actions : prévu (lancement auto des tests)

📝 UI / UX / Docs — En amélioration continue

README.md : terminé (présentation publique enrichie)

README_DEV.md : terminé (vue développeur claire)

Magasin de modules : prévu (UI pour activer/désactiver)

Tutoriel interactif : prévu (onboarding avec IA + OCR)

🔄 Règle de mise à jour

Ce fichier ne liste que les grandes étapes :

Il doit rester lisible, synthétique et global.

Pour les détails → consulter : 

noyau_suivi.md → tâches internes du noyau

suivi_[module].md → suivi fin par module



- ✅ Mise à jour automatique des tâches le 2025-06-04
