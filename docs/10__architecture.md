🏗️ 10__architecture.md — Architecture technique et fonctionnelle d’AniSphère

Ce document décrit l’architecture complète d’AniSphère, conçue pour être modulaire, évolutive, performante, et optimisée par l’intelligence artificielle. Elle prend en compte la nécessité de limiter les coûts Firebase, d’assurer un fonctionnement hors ligne fluide, de gérer un très grand nombre d’utilisateurs et d’animaux, et de garantir une ergonomie maximale.

🧱 Fondations de l’architecture AniSphère

Flutter : framework unique pour Android, iOS, web (futur) et desktop.

Hive : base de données locale ultra-rapide, prioritaire pour toutes les données non critiques.

Firebase : uniquement pour les fonctions cloud critiques (auth, stockage partagé, synchronisation IA cloud).

TFLite + OpenCV : IA locale embarquée (OCR, reconnaissance visuelle, analyse comportementale).

Architecture modulaire : séparation complète entre le noyau et les modules, tous indépendants et téléchargeables à la demande.

⚙️ Noyau central

Le noyau est le cœur de l’application. Il gère :

Authentification (email, Google, Apple)

Comptes utilisateurs (statistiques, rôles dynamiques, paramètres)

Profils animaux (données de base, modules actifs, IA locale)

Stockage hybride (Hive local + Firestore différé)

Synchronisation automatique IA + données critiques

IA maîtresse (optimisation Firebase, alertes, personnalisation)

Notifications (urgentes, programmées, contextuelles)

Gestion de la boutique de modules + activation

Export PDF brut

Interface guidée au lancement

`home_screen.dart` sert de tableau de bord. Il récupère la liste des modules actifs pour afficher leurs widgets de résumé. Chaque module expose un `SummaryCard` dans `lib/modules/<module>/widgets/`. Les utilisateurs peuvent réordonner ces cartes et l’ordre est sauvegardé localement via Hive.

🧩 Modules indépendants et connectés

Chaque module est développé comme un composant autonome :

Il dispose de sa propre IA locale + règles cloud si nécessaire

Il est activé/désactivé via la boutique (et chargé uniquement si actif)

Il a son propre suivi, interface, données, et permissions

Modules principaux (exemples) :

Santé (vaccins, carnet, vétérinaire, antiparasitaires)

Éducation (exercices, phases, progrès IA)

Dressage (canicross, pistage, recherche, agilité)

Communauté (entraide, sphères, échanges, alertes fugue)

Fugue (photo d’identification, alerte automatique, page publique)

## 🧩 Répartition générale du code (lib/)

### lib/modules/

* **noyau/** : coeur de l'application (auth, IA, services globaux, synchronisation, UI commune)
* **identite/** : module identité animal (OCR, badge, éleveur, QR, documents)
* à venir : **sante**, **education**, **dressage**, **communaute**, etc.

### lib/modules/noyau

Organisation stricte en 6 sous-dossiers principaux :

* **models/** : modèles de données Hive + Firebase (user\_model, animal\_model, support\_ticket\_model, etc.)
* **services/** : logique metier et accès Hive/Firebase (user\_service, auth\_service, offline\_sync\_queue, firebase\_service...)
* **screens/** : écrans principaux et secondaires du noyau (login\_screen, main\_screen, splash\_screen, settings\_screen, etc.)
* **logic/** : logique IA locale (ia\_master, ia\_executor, ia\_rule\_engine, ia\_flag, etc.)
* **ia_recommendation/** : moteur de recommandation IA (local + cloud)
* **providers/** : state management avec Provider (user\_provider, animal\_provider, ia\_context\_provider, **theme\_provider**)
* **widgets/** : composants visuels réutilisables (ia\_banner, ia\_chip, ia\_log\_viewer, notification\_icon, etc.)
* **storage/** : fichiers partagés ou intermodulaires (ex : stockage IA modulaire)

## 🧠 IA Maîtresse (locale)

L'intelligence artificielle locale est déployée dans le noyau selon un système modulaire complet :

* **ia\_context.dart** : fournit le contexte actuel IA (connexion, animaux, sync...)
* **ia\_rules.dart** : contient les règles IA de base
* **ia\_rule\_engine.dart** : applique les règles en fonction du contexte
* **ia\_executor.dart** : applique les actions IA concrètes (notifications, sync, UI)
* **ia\_scheduler.dart** : planifie les exécutions IA (6h, au démarrage, etc.)
* **ia\_logger.dart** : journalise les actions IA
* **ia\_flag.dart / ia\_channel.dart / ia\_config.dart** : configuration, canaux, drapeaux IA

L'appel principal se fait dans **main.dart > MainScreen**, avec le Provider **IAContextProvider**.

## 📦 Modules externes (identite/, à venir : sante/, education/...)

Chaque module suit la même architecture que noyau/ :

* **models/** : modèles propres au module
* **services/** : services dédiés (OCR, IA, Firebase, etc.)
* **screens/** : écrans spécifiques (identity\_screen, etc.)
* **logic/** : logique IA locale du module (si applicable)
* **widgets/** : composants visuels du module

## 🧪 Tests

* Tous les tests sont rangés dans le dossier `/test` par catégorie : `test/noyau/`, `test/modules/`, etc.
* Les tests unitaires suivent la structure des services/modèles.
* Les scripts d'automatisation se trouvent dans `/scripts/` :

  * `generate_test_module.dart`
  * `update_test_tracker.dart`
  * `update_suivi_taches.dart`
  * `update_noyau_suivi.dart`

## 🔄 Synchronisation automatique

Le projet utilise des workflows GitHub Actions pour :

* Lancer les tests automatiquement (`flutter_tests.yml`)
* Mettre à jour les suivis `test_tracker.md`, `noyau_suivi.md`, `suivi_taches.md` automatiquement

Fichiers déclencheurs :

* `.github/workflows/update_test_tracker.yml`
* `.github/workflows/update_noyau_suivi.yml`
* `.github/workflows/update_suivi_taches.yml`

## 📁 Dossiers de documentation (docs/)

* `0__instructions.md` : structure de base
* `2__roadmap.md` : roadmap par phase
* `3__suivi_taches.md` : tableau de bord global
* `noyau_suivi.md` : suivi complet du noyau
* `suivi_identite.md` : suivi complet module identité
* `test_tracker.md` : suivi des tests
* `10__architecture.md` : ce fichier

## ✅ Statut

L’architecture actuelle est **optimale, modulaire, testable et IA-ready**.
Chaque module est isolé, chaque fichier testable, et chaque logique IA supervisable.
Les modules futurs peuvent s’ajouter **sans casser le noyau**, tout en bénéficiant de la structure IA centrale.

Prochaine étape : étendre cette architecture au module **Santé** ou **Éducation** avec la même logique.


🤖 IA intégrée à chaque étage

Locale (TFLite) : OCR, suggestions, rappels, suivi comportemental embarqué

Cloud : analyse globale anonymisée, apprentissage partagé, modèles adaptatifs

Maîtresse IA (noyau) : 

Supervision des autres IA

Optimisation Firebase (compression, tri, upload différé)

Personnalisation de l’expérience utilisateur

Explicabilité IA (justification des suggestions)

Amélioration continue des modules (recommandation, tri, désactivation automatique si inutile)

🌐 Synchronisation intelligente

Par défaut, tout est stocké localement (même connecté)

Synchronisation Firebase : 

Déclenchée uniquement si nécessaire (action critique, partage, backup cloud)

Regroupée en lots compressés pour minimiser les accès

Automatiquement différée par l’IA pour éviter les pics ou coûts inutiles
Gestion dynamique des modes de partage via `SharingConnectivityManager`
Optimisation des envois par `SharingIaOptimizer` (compression et déduplication)

Données sensibles exclues du cloud (nom, prénom, téléphone)

🛡️ Sécurité et confidentialité intégrées

Authentification OAuth / Google / Apple

Chiffrement des données locales (Hive chiffré)

Gestion fine des permissions par module + rôle utilisateur

Données critiques sauvegardées uniquement avec consentement explicite

🧠 IA + UX : une architecture centrée sur l’utilisateur

L’IA apprend en continu pour fluidifier l’expérience (pas d’options inutiles, navigation personnalisée)

Le système s’auto-adapte selon l’usage réel (modules suggérés ou désactivés)

L’interface est pensée pour créer une relation quotidienne fluide, agréable et cohérente

📈 Vision long terme

Architecture scalable à très grand nombre d’animaux et d’utilisateurs

IA comme infrastructure d’optimisation temps réel, financière, et ergonomique

Système modulaire prêt pour des dizaines de nouveaux modules

Version Web + API publique + dashboard admin professionnel à venir

AniSphère repose sur une architecture modulaire, hybride et intelligente, taillée pour accompagner l’évolution constante des usages, tout en gardant un coût optimisé, une UX exceptionnelle, et une IA au cœur du pilotage.


### Partage et synchronisation
AniSphère dispose d'un service de partage local (Bluetooth, Wi‑Fi Direct, NFC, QR) et d'un service cloud. La détection automatique choisit le meilleur mode disponible; le partage cloud requiert un compte premium.

### Services transverses du noyau
Le noyau met à disposition plusieurs services communs accessibles par tous les modules :
- **Messagerie interne** : `lib/modules/messagerie/services/messaging_service.dart` et sa file d'attente `offline_message_queue.dart`.
- **Partage local et cloud** : `lib/modules/noyau/services/local_sharing_service.dart` et `cloud_sharing_service.dart`, avec suivi via `share_history_service.dart`.
- **Commande vocale** : `lib/modules/voice/speech_recognition_service.dart` et `voice_command_analyzer.dart` pour déclencher rapidement des actions.
- **Notifications intelligentes** : `lib/modules/noyau/services/notification_service.dart` connectée à l'IA maîtresse.
- **Exports et historiques** : `lib/modules/noyau/noyau_module.dart` ainsi que `share_history_service.dart` pour générer des PDF ou archives.
- **File de synchronisation offline** : `lib/modules/noyau/services/offline_sync_queue.dart`.
Ces services garantissent la cohérence entre les modules et simplifient leur intégration.
