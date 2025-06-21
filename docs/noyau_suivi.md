# ✅ Suivi chronologique du développement — Noyau d’AniSphère
*Fichier mis à jour au 21/06/2025*

Ce fichier suit **étape par étape, dans l’ordre**, la conception, l’évolution, les tests et les grandes décisions du noyau AniSphère.  
> Toute étape validée est datée, toute fonctionnalité doit être couverte par un test associé.  
> Les tâches Superadmin ont été supprimées du noyau et sont désormais dans un module indépendant.

---

## 📅 Chronologie du développement

---

### **Mars 2024 — Pré-projet & premiers jalons**
- 🔹 Idée : créer une application modulaire pour le suivi intelligent animalier (particulier, pro)
- 🔹 Définition des bases : Flutter, Hive, Firebase, IA locale/cloud
- 🔹 Création des dossiers : `lib/core/`, `lib/modules/`, `docs/`, `test/`, `scripts/`
- 🔹 Rédaction des premiers fichiers de directives (`0__instructions.md`, `2__roadmap.md`, `10__architecture.md`)
- 🔹 Premiers schémas d’architecture modulaire et du noyau

---

### **Avril 2024 — Initialisation technique**
- [04/2024] Initialisation du projet Flutter + configuration Firebase (`main.dart`, `firebase_options.dart`)
- [04/2024] Intégration de Hive (`app_initializer.dart`)
- [04/2024] Authentification : création du modèle utilisateur (`user_model.dart`) et du service utilisateur (`user_service.dart`)
- [04/2024] Connexion, inscription, gestion multi-profils (`auth_service.dart`, `login_screen.dart`, `register_screen.dart`)
- [04/2024] Stockage local priorisé (Hive) + premier jet de synchronisation Firebase
- [04/2024] Mise en place des premiers tests unitaires sur modèles/services (test/noyau/unit/)

---

### **Mai 2024 — Gestion des animaux & structure modulaire**
- [05/2024] Modèle animal (`animal_model.dart`), service associé (`animal_service.dart`)
- [05/2024] Gestion utilisateur ↔ animaux : liaison, CRUD, synchronisation locale/cloud
- [05/2024] Provider global (`user_provider.dart`, `animal_provider.dart`)
- [05/2024] Écrans principaux : `main_screen.dart` (4 onglets fixes), `animals_screen.dart`, `animal_form_screen.dart`, `animal_profile_screen.dart`
- [05/2024] Intégration d’une navigation fluide inspirée Samsung Health
- [05/2024] Tests unitaires et widgets de base en place (test/noyau/widget/)

---

### **Juin 2024 — Modules, boutique et IA locale**
- [06/2024] Ajout du module “boutique” : gestion dynamique des modules (`modules_screen.dart`, `modules_service.dart`)
- [06/2024] Préparation du modèle d’activation/désactivation, gestion des rôles par module
- [06/2024] Début de la logique IA maîtresse locale :  
    - `ia_master.dart` (décision centrale)
    - `ia_rule_engine.dart`, `ia_executor.dart`, `ia_scheduler.dart`, `ia_logger.dart` (logique, exécution, logs)
- [06/2024] Widgets IA stylés (inspirés Samsung Health) : `ia_chip.dart`, `ia_banner.dart`, `ia_suggestion_card.dart`, `ia_log_viewer.dart`
- [06/2024] Ajout du suivi test auto via scripts (`generate_test_module.dart`, `update_test_tracker.dart`)

---

### **Juillet–Août 2024 — Optimisation, UX, automatisation**
- [07-08/2024] Optimisation de la synchronisation différée Hive/Firebase
- [07-08/2024] Nettoyage du code, factorisation, documentation automatisée
- [07-08/2024] UX améliorée : `home_screen.dart` enrichi, animations, slide up, onboarding contextuel IA
- [07-08/2024] Tests CI/CD automatisés sur chaque push (GitHub Actions)

---

### **Septembre–Novembre 2024 — Notifications, sécurité, rôles**
- [09-11/2024] Service notifications locales (`notification_service.dart`, `notification_icon.dart`)
- [09-11/2024] Amélioration sécurité : stockage chiffré local, permissions module, préparation double authentification
- [09-11/2024] Affinage des rôles utilisateurs (pro, particulier, asso) dans `user_model.dart`, UI à venir

---

### **Décembre 2024 – Janvier 2025 — Maintenance, refonte tests, IA invisible**
- [12/2024-01/2025] Maintenance IA locale : purge, correction automatique, logs intelligents, triggers auto (scheduler)
- [12/2024-01/2025] Refonte de la structure de tests et du suivi Markdown
- [01/2025] L’IA maîtresse devient invisible pour l’utilisateur standard (demande validée)

---

### **Février–Mars 2025 — Export, partage, monétisation**
- [02-03/2025] Début du module d’export PDF, QR et partage (`share_screen.dart`, `pdf_export_service.dart`, `qr_service.dart`)
- [02-03/2025] Première intégration monétisation (boutique modules, base premium)
- [02-03/2025] Automatisation du suivi : chaque feature ajoutée met à jour `noyau_suivi.md` et `test_tracker.md`

---

### **Avril–Mai 2025 — Finalisation IA locale, modularité totale**
- [04-05/2025] Finalisation et nettoyage IA locale :  
    - `ia_master.dart`, `ia_rule_engine.dart`, `ia_executor.dart`, `ia_scheduler.dart`, `ia_logger.dart`, etc.
    - Tests unitaires pour chaque logique IA, correction edge-cases
- [04-05/2025] Navigation principale complète :  
    - `main_screen.dart` (onglets, menu, QR, notifications)
    - `home_screen.dart`, `modules_screen.dart`, `animals_screen.dart`, `settings_screen.dart`, `share_screen.dart`
- [04-05/2025] Correction des derniers bugs d’intégration (offline/online), amélioration tests CI
- [04-05/2025] **Module Superadmin intégré temporairement dans le noyau** pour tests (logs avancés, flags IA, resync manuel, scoring technique…)

---

### **Mai–Juin 2025 — Sécurité ultime et extraction du Superadmin**
- [05/2025] Prise de décision stratégique :  
    - **Superadmin ne doit plus être dans le noyau** pour sécurité, conformité et maintenance.
- [05/06/2025]  
    - Suppression de `superadmin_screen.dart`
    - Suppression/Nettoyage de tous les accès, widgets, providers, services Superadmin
    - Documentation et suivi déplacés dans le futur module `superadmin`
    - Le noyau ne garde **que la supervision minimale** (logs IA de debug pour développeur local, jamais accessibles en prod)
    - **Nouveau suivi “noyau” = 100% sans Superadmin**
- [05/06/2025]  
    - Optimisation structure du suivi, priorités IA cloud, sécurité, automatisation des tests, modularité stricte

### **Juin 2025 — Préparation de la messagerie**
- [06/2025] Définition de la collection `messages` (conversations, messages).
- [06/2025] Création du dossier module `messagerie` et des premiers tests vides. *(Ce module sera intégré au noyau mi-juin 2025 — voir plus bas)*
- [06/2025] Correction du crash au démarrage lorsque `currentUser` était `null`.

### **Juin 2025 — Gestion photo & file offline**
- [06/2025] Ajout du `camera_service.dart` pour la capture et le pré-traitement des images.
- [06/2025] Création du modèle `photo_model.dart` (métadonnées, stockage Hive).
- [06/2025] Mise en place de `offline_photo_queue.dart` pour la synchronisation différée des clichés et pré-analyse IA.
- [06/2025] Ajout de `offline_gps_queue.dart` pour enregistrer les traces GPS hors ligne et analyse IA.
- [06/2025] Tests unitaires : `offline_photo_queue_test.dart`, `offline_gps_queue_test.dart`.
- [06/2025] Tests unitaires : `camera_service_test.dart`, `photo_model_test.dart`.
- [06/2025] Création du `gps_service.dart` pour la localisation et la gestion du flux de positions.
- [06/2025] Ajout du modèle `share_history_model.dart` et de l'historique de partage Hive. *(Initialement prévu dans le module partage)*
- [06/2025] Mise à jour de `share_screen.dart` avec partage local/cloud et statut de connexion.
---
- [06/2025] Préparation de l'infrastructure d'analyse vidéo (`video_analysis_service.dart`, `video_upload_queue.dart`) — *désactivée par défaut*.
## 🚩 Statut actuel du noyau (05/06/2025)

| Fonction / Phase                      | Statut   | Fichiers clés                                     | Tests         | Commentaire                      |
|---------------------------------------|----------|---------------------------------------------------|---------------|----------------------------------|
| Initialisation, Auth, Utilisateur     | ✅ Fait   | main.dart, app_initializer, user_model/service     | Oui           | Hive + Firebase                  |
| Gestion animaux                       | ✅ Fait   | animal_model/service, animal_provider              | Oui           | Local/cloud, UI & tests ok       |
| Modules & boutique                    | ✅ Fait   | modules_screen/service                            | Oui           | Activation dynamique, testée     |
| IA maîtresse locale                   | ✅ Fait   | ia_master, ia_rule_engine, ia_executor, ia_scheduler, ia_logger | Oui | Décision, exécution, logs        |
| Notifications                         | ✅ Fait   | notification_service, notification_icon            | Oui           | Local, à étendre à FCM           |
| Navigation, UI principale             | ✅ Fait   | main_screen, home_screen, settings_screen, etc.    | Oui           | Ergonomie validée                |
| Export & partage animal               | 🔄 En cours | share_screen, pdf_export_service, qr_service      | Non           | Export PDF à finaliser (désormais service noyau) |
| Rôles & multi-utilisateurs            | 🔄 En cours | user_model, settings_screen                       | Non           | UI assignation rôles à finir     |
| Sécurité avancée                      | 🔄 En cours | local_storage_service, user_service               | Non           | Chiffrement, double auth         |
| Biométrie & PIN                       | 🔄 À démarrer | biometric_auth_service, pin_code_service, auth_lock_screen | Non           | Auth biométrique avec code PIN secours |
| IA cloud (sync, scoring, logs)        | 🔄 À démarrer | ia_master (syncToCloud), cloud_sync_service      | Non           | Synchronisation premium          |
| Messagerie interne                    | 🔄 En cours | messages_service, messaging_screen              | Non           | Migrée du module vers le noyau   |
| Commandes vocales / mains libres      | 🔄 En cours | speech_recognition_service, voice_command_analyzer | Non           | Module vocal devenu service noyau |
| **Superadmin**                        | ❌ Migré  | —                                                 | —             | Maintenant module indépendant    |
| Prise de photo & file offline         | 🔄 À démarrer | camera_service, photo_model, offline_photo_queue, offline_gps_queue | Non           | Capture locale, sync différée    |
| Job scheduler interne                 | 🔄 En cours | job_scheduler_service, job_model, job_provider, scheduler_hooks | Oui           | Planification automatique des tâches |

### Sécurité avancée

AniSphère introduit une authentification biométrique (empreinte digitale ou reconnaissance faciale) pour ouvrir l’application. En cas d’échec ou d’indisponibilité, un code PIN chiffré permet de poursuivre l’accès. Cette approche garantit la sécurité tout en restant simple et rapide pour l’utilisateur.

---

## 🛠️ Fichiers principaux du noyau (hors Superadmin)

- `main.dart`, `app_initializer.dart`
- `user_model.dart`, `user_service.dart`, `auth_service.dart`
- `animal_model.dart`, `animal_service.dart`, `animal_provider.dart`
- `main_screen.dart`, `home_screen.dart`, `modules_screen.dart`, `settings_screen.dart`, `share_screen.dart`, `animal_form_screen.dart`, `animal_profile_screen.dart`
- `notification_service.dart`, `notification_icon.dart`
- `camera_service.dart`, `photo_model.dart`, `offline_photo_queue.dart`
- `gps_provider.dart`, `offline_gps_queue.dart`
- `ia_master.dart`, `ia_rule_engine.dart`, `ia_executor.dart`, `ia_scheduler.dart`, `ia_logger.dart`
- **Tests** dans `test/noyau/`
- **Scripts d’automatisation** : `generate_test_module.dart`, `update_noyau_suivi.dart`

---

## ❌ Fichiers Superadmin supprimés / migrés

- `superadmin_screen.dart`  
- Widgets/providers/services dédiés  
- Menus, flags, accès, logique spécifiques  
- Documentation & suivi → déplacés vers `docs/suivi_superadmin.md`

---

## 📌 Priorités actuelles / tâches restantes

- Finaliser la synchronisation IA cloud (upload Firebase, scoring, logs, IA premium)
- Finaliser l’export PDF & partage (animal, QR, page publique…)
- UI de gestion des rôles multi-utilisateurs
- Renforcer le chiffrement et la sécurité (permissions, double auth, gestion hors-ligne chiffrée)
- Poursuivre l’automatisation des tests (unit/widget/intégration) pour toute nouvelle brique
- Rafraîchir le suivi Markdown et la documentation à chaque étape (script `update_noyau_suivi.dart`)
- Créer le module indépendant `superadmin` (lib/modules/superadmin/), suivi dédié
- Finaliser l’intégration de `camera_service` et de la `offline_photo_queue`

### Nouveaux services IA & capteurs
| Élément | Description | Statut |
|---------|-------------|--------|
| device_sensors_service.dart | Accès centralisé à tous les capteurs | ⬜ à faire |
| gps_provider.dart | Flux position + connexion | ✅ fait |
| ia_context_enricher.dart | Contexte IA enrichi temps réel | ⬜ à faire |
| behavior_analysis_service.dart | Analyse comportementale IA (TFLite/capteurs) | ✅ fait |
| image_analysis_service.dart | IA analyse images/photo (TFLite) | ⬜ à faire |
| engagement_score_model.dart | Modèle scoring engagement IA | ⬜ à faire |
| ia_adaptation_service.dart | Priorisation/ajustement IA selon contexte | ⬜ à faire |
| behavior_dashboard_screen.dart | UI historique et recommandations | ⬜ à faire |
| ia_recommendation/ (nouveau dossier) | Système de recommandation IA locale/cloud | ✅ fait |

- [06/2025] Tests unitaires : `behavior_analysis_service_test.dart`.

### Sécurité biométrique
| Fichier | Statut |
|---------|-------|
| lib/modules/noyau/services/biometric_auth_service.dart | ✅ fait |
| lib/modules/noyau/models/security_settings_model.dart | ✅ fait |
| lib/modules/noyau/screens/security_settings_screen.dart | ✅ fait |
| lib/modules/noyau/widgets/biometric_guard.dart | ✅ fait |

### Consentement RGPD
| Fichier | Rôle |
|---------|------|
| functions/index.js | Fonction Cloud enregistrant les données sensibles et le `consentementIA` |
| docs/ia_policy.md | Politique détaillée sur l'anonymisation et le traitement des données |
| lib/modules/noyau/models/security_settings_model.dart | Stockage local des choix de sécurité et de consentement |
| lib/modules/noyau/screens/security_settings_screen.dart | Interface pour modifier ou révoquer son consentement |

### ❌ Multilingue (i18n) retiré
- Le dossier `lib/modules/noyau/i18n/` et les fichiers de traduction ont été supprimés.
- L’application reste uniquement en français.

---

## 🗂️ Annexes & liens

- [README_DEV.md](README_DEV.md) — Vue développeur & routine
- [3__suivi_taches.md](3__suivi_taches.md) — Suivi macro projet
- [test_tracker.md](test_tracker.md) — Couverture et état des tests
- [10__architecture.md](10__architecture.md) — Architecture technique
- [7__ia.md](7__ia.md) — Architecture IA et files offline
- [suivi_superadmin.md](suivi_superadmin.md) — Module Superadmin

---

## 📝 Historique des décisions majeures

- **05/06/2025** : Extraction Superadmin → module sécurisé indépendant. Nettoyage du noyau.
- **05/2025** : Préparation IA cloud, priorité sécurité, modularité renforcée.
- **06/2025** : Introduction du `camera_service`, de `photo_model` et de la `offline_photo_queue` pour gérer la prise de vue hors ligne, ainsi que `offline_gps_queue` pour stocker les traces GPS.
- **04–05/2025** : Finalisation IA locale, navigation, automatisation test/suivi.
- **03–04/2024** : Création de la structure modulaire, bases IA, stockage optimisé, automatisation du suivi.

---

**Le noyau AniSphère doit rester minimal, autonome, sécurisé, évolutif, et intégralement testable.  
Toute évolution doit être documentée ici, commitée, testée, et suivie dans GitHub et les scripts.**


- 🧩 Synchronisation automatique du noyau le 2025-06-09
- 🚮 Nettoyage final : aucun fichier SuperAdmin dans le noyau
- 🧩 Synchronisation automatique du noyau le 2025-06-10
- 🧩 Synchronisation automatique du noyau le 2025-06-11

- 🧩 Synchronisation automatique du noyau le 2025-06-13
📁 Configuration manuelle initiale dans Firestore — AniSphère (non gérée via Flutter)

Dernière mise à jour : 2025-06-13
Responsable : Superadmin

---

🌟 Objectif : Préparer manuellement les collections et documents Firestore qui **ne seront pas créés automatiquement** via Flutter, afin que les modules critiques (noyau, IA cloud, identité) puissent fonctionner sans erreur.

---

## ✅ À créer manuellement dans Firestore

### 1. Collection `ia_categories/`

* 📂 `ia_categories/sante/uploads`
* 📂 `ia_categories/sante/models`
* 📂 `ia_categories/sante/feedbacks`
* 📂 `ia_categories/education/uploads`
* 📂 `ia_categories/education/models`
* 📂 `ia_categories/education/feedbacks`
* 📂 `ia_categories/dressage/uploads`
* 📂 `ia_categories/dressage/models`
* 📂 `ia_categories/dressage/feedbacks`
* 📂 `ia_categories/communaute/uploads`
* 📂 `ia_categories/communaute/models`
* 📂 `ia_categories/communaute/feedbacks`

### 2. Collection `logs_ia/`

* 📂 `logs_ia/sante`
* 📂 `logs_ia/education`
* 📂 `logs_ia/dressage`
* 📂 `logs_ia/communaute`

### 3. Collection `consents/`

* 📄 `consents/global`

  * 🔢 `current_version` : 1
  * 🕒 `last_update` : \[timestamp actuel]
  * 📜 `description` : "Consentement RGPD pour synchronisation IA (anonymisée)"
  * ✅ `required` : true

### 4. Collection `superadmin/`

* 📄 `superadmin/flags`

  * 🔁 `start_training_sante` : false
  * 🔁 `start_training_education` : false
  * 🔁 `start_training_dressage` : false
  * 🔁 `start_training_communaute` : false

---

## 📌 Où suivre l'avancement de cette configuration ?

➞ Mise à jour **manuelle** dans ce document : [docs/firestore_setup.md](docs/firestore_setup.md)
➞ Synthèse globale à reporter dans : `docs/noyau_suivi.md` (section "Préparation Firestore IA") et `3__suivi_taches.md` (section noyau)

---

✅ Ce document est un repère **temporaire**, en attendant que ces données puissent être gérées automatiquement (ex : via script d’init Firebase ou via IAMaster avec `createIfNotExists`).

- 🧩 Synchronisation automatique du noyau le 2025-06-14
- 🆕 2025-06-15 : Ajout des services LocalSharingService, CloudSharingService et PremiumSharingChecker (module partage).
- 🆕 2025-06-15 : Mise en place du module vocal initial (SpeechRecognitionService, VoiceCommandAnalyzer, UI mains-libres).
- 🆕 2025-06-20 : Migration de la messagerie et des services de partage dans le noyau (messages_service, share_screen, LocalSharingService...).
- 🆕 2025-06-22 : Intégration du module vocal au noyau (speech_recognition_service, voice_command_analyzer, UI mains-libres).
- 🆕 2025-06-27 : Création du job scheduler interne (service, modèle, provider, hooks).
- 🆕 2025-06-30 : Ajout de l’EventBus interne (services, provider, hooks et queue offline).
- [06/2025] Ajout système IA de déclenchement intelligent d’essai Premium. Fichiers créés : `premium_trial_manager.dart`, `premium_trial_trigger.dart`, `premium_trial_notifier.dart`. Critères IA définis dans `ia_metrics_collector.dart`. Comparatif activé.

- 🧩 Synchronisation automatique du noyau le 2025-06-15
- 🧩 Création du PaymentService (`payment_service.dart`) avec tests unitaires le 2025-06-15
- 🧩 Mise en place du SubscriptionModel (`subscription_model.dart`) couvert par tests le 2025-06-15
- 🧩 Ajout du SubscriptionProvider (`subscription_provider.dart`) avec tests le 2025-06-15
- 🧩 Ajout du PaymentValidator (`payment_validator.dart`) avec tests le 2025-06-15
- 🧩 Nouvelle interface PaymentScreen (`payment_screen.dart`) couverte par tests le 2025-06-15
- 🧩 Mise à jour de `ia_logger.dart` pour tracer les paiements, tests à jour le 2025-06-15

- 🧩 Synchronisation automatique du noyau le 2025-06-18
- 🆕 Multilingue : i18n_service, i18n_provider, fichiers .arb
- 🆕 Support complet de **10 langues** grâce à `i18n_service.dart` et aux fichiers `.arb` localisés
- 🛠️ 2025-06-30 : Correction des imports i18n (`AppLocalizations`, `I18nProvider`) et mise à jour des tests associés
- 🆕 2025-07-15 : Gestion rôles utilisateurs / validation pro via `user_profile_model.dart` et `pro_validation_service.dart`

- 🧩 Synchronisation automatique du noyau le 2025-06-19
- 🆕 2025-06-21 : Ajout du module **Identité** dans `ModulesScreen` (catégorie "Communauté") et localisation dans les fichiers `.arb`.
- 🛠️ 2025-06-21 : `ModuleCard` devient cliquable et ouvre `IdentityScreen` via `_openIdentityScreen`.
- ✅ 2025-06-21 : Test widget `modules_screen_test.dart` mis à jour pour vérifier l'accès à l'identité.
- 🛠️ 2025-06-21 : Nettoyage des fichiers de localisation (`lib/l10n/*.arb`) et ajout des clés `ai_score`, `breeder_name`, `breeder_email`, `breeder_phone`, `onboarding_title`, `onboarding_subtitle`, `onboarding_skip`, `onboarding_next`, `duplicate_animal_warning`, `duplicate_photo_warning`, `photo_timeline_title`.
- 🛠️ 2025-06-21 : Mise à jour du `identity_model.dart` (champs éleveur) avec tests.

- 🧩 Synchronisation automatique du noyau le 2025-06-21
