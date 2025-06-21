🧭 Objectifs du fichier

Ce fichier regroupe toutes les informations nécessaires au développement de l’application AniSphère, que ce soit pour un développeur principal (toi) ou d’autres contributeurs ponctuels. Il sert à structurer ton travail, automatiser le suivi, et connecter tes outils de développement intelligents (Copilot, ChatGPT, IA maîtresse du noyau, tests automatiques).

Il a 3 fonctions principales :

Donner un point d’entrée clair pour tout développement

Centraliser les bonnes pratiques, automatisations, et outils

Servir de passerelle entre le code, l’IA et les fichiers de suivi (test, roadmap, modules)

Il est mis à jour automatiquement à chaque évolution majeure du projet.
Le système multilingue est **désactivé temporairement** pour simplifier la première version : l’application fonctionne donc uniquement en français.
Les fichiers `.arb` restent toutefois présents dans `lib/l10n/` pour préparer une future réactivation.
Lorsque la traduction sera réactivée, tous les textes devront passer par `AppLocalizations.of(context)` et le service central `lib/modules/noyau/i18n/`.
`localeResolutionCallback` dans `lib/main.dart` force actuellement la langue française.
📌 Version Flutter/Dart requise

Le développement d'AniSphère s'appuie sur **Flutter&nbsp;3.32.x** et **Dart&nbsp;3.4+**.
Les scripts de CI (GitHub Actions) utilisent cette version pour lancer
les tests et la compilation. Veillez à utiliser la même version en local
pour éviter toute incompatibilité.
Ces versions sont indispensables pour exécuter les tests et le script
`generate_test_module.dart`. Une fois le code d'analyse vidéo ajouté,
pensez à lancer `flutter test` dès que ces outils sont disponibles.

📌 Version Node.js requise

Les fonctions Firebase reposent sur **Node.js 20**. Installez cette version ou
une version compatible avant d'exécuter ou de développer les Cloud Functions en
local.

### Gestion des modèles IA

Placez tous les modèles `.tflite` ou `.pkl` dans `assets/models/` et ajoutez
leurs chemins dans `pubspec.yaml` sous `flutter/assets`. Exécutez ensuite
`flutter pub get` pour que Flutter prenne ces fichiers en compte. Lorsque
`IaModelUpdater` télécharge un modèle au démarrage, ce dossier sert de chemin de
secours. `IaModelLoader` copie ensuite le fichier dans `ApplicationDocumentsDirectory`,
et `IaInterpreterLoader` instancie l'interpréteur TFLite pour l'utiliser dans les services.
ℹ️ Notes d’utilisation du module Partage pour les contributeurs
- Testez toujours le partage local hors connexion avant de valider une mise à jour.
- Les fonctions cloud nécessitent un compte Premium de test ; utilisez `lib/core/sharing` pour simuler la synchro.
- Documentez les évolutions dans `docs/3__suivi_taches.md` et `docs/0__instructions.md`.
- Pour l'appel des fonctions cloud, consultez `docs/firebase_function_examples.md`.
- Téléchargez `GoogleService-Info.plist` depuis la console Firebase et placez ce fichier dans `ios/Runner/`. Un gabarit est disponible sous `ios/Runner/GoogleService-Info.plist.example`. Comme ce fichier contient des identifiants sensibles, il doit rester local et ne pas être commité.
- Suivez [docs/firestore_setup.md](docs/firestore_setup.md) pour préparer manuellement les collections Firestore et lancer le script de vérification.
- Consultez [docs/4__gestion_des_collections.md](docs/4__gestion_des_collections.md#collection-logs_ia) pour le format détaillé des logs IA.

🗂️ Chapitre 2 — Structure du projet Flutter

Voici la structure actuelle recommandée pour AniSphère, organisée pour séparer clairement le noyau, les modules, les services, et les tests :

lib/ ├── core/ # Noyau central : utilisateurs, animaux, IA, modules, partage… ├── modules/ # Modules indépendants (santé, éducation, dressage, etc.) ├── services/ # API, Firebase, OCR, stockage, IA cloud ├── models/ # Modèles de données (utilisateur, animal, module, etc.) ├── providers/ # Providers (état global via Provider ou Riverpod) ├── screens/ # Écrans principaux (accueil, partage, paramètres…) ├── utils/ # Fonctions utilitaires, constantes, helpers └── test/ # Tests automatisés : unit, widget, intégration

Règles :

Chaque module dispose de son propre dossier dans lib/modules/[nom_du_module]

Le noyau est toujours accessible depuis les modules, mais les modules ne doivent jamais l’altérer

Tous les tests sont regroupés dans /test et suivent la même hiérarchie que lib/
Tous les textes des modules doivent passer par `AppLocalizations.of(context)` et les services utilisent `I18nService` pour la langue active. Aucune ressource `.arb` ne doit être créée dans les modules.

### Services transverses du noyau
- Messagerie : `lib/modules/messagerie/services/messaging_service.dart`
- Partage local/cloud : `lib/modules/noyau/services/local_sharing_service.dart`, `cloud_sharing_service.dart`
- Voix : `lib/modules/noyau/services/speech_recognition_service.dart`
- Notifications : `lib/modules/noyau/services/notification_service.dart`
- Exports : `lib/modules/noyau/services/share_history_service.dart`
- File offline : `lib/modules/noyau/services/offline_sync_queue.dart`


⚙️ Chapitre 3 — Automatisation du développement

L’automatisation est au cœur du développement d’AniSphère pour gagner du temps, réduire les oublis, et faciliter l’organisation. Voici les systèmes déjà en place ou prévus :

✅ Scripts personnalisés

generate_test_module.dart
→ Génère automatiquement tous les fichiers de test (unit, widget, integration) pour un module.

update_test_tracker.dart
→ Met à jour automatiquement le fichier docs/test_tracker.md avec les tests manquants ou créés.

✅ GitHub Actions (CI/CD)

flutter_tests.yml : → Lance automatiquement tous les tests (flutter test) à chaque push ou pull request.

update_test_tracker.yml : → Met à jour automatiquement le suivi de test après chaque commit avec modification d’un fichier test/.

✅ Extensions recommandées pour VS Code

Flutter / Dart : développement de l’application

GitHub Copilot + Copilot Chat : autocomplétion intelligente, génération d’exemples, refactoring

Markdown All in One : confort de lecture pour les fichiers .md

Error Lens : erreurs visibles immédiatement dans le code

Bracket Pair Colorizer 2 : lisibilité du code améliorée

🧪 Chapitre 4 — Types de tests et convention

AniSphère intègre un système de tests automatisés rigoureux et bien organisé. Voici les types de tests utilisés et les conventions à respecter.

🔸 Types de tests

Tests unitaires (unit) :

Testent une fonction ou un composant isolé (service IA, modèle, utilitaire)

Tests widget (widget) :

Vérifient qu’un widget Flutter fonctionne correctement (apparence, interaction, rendu)

Tests d’intégration (integration) :

Simulent un parcours utilisateur complet (ex. : créer un animal, lui affecter un module, partager son profil)

🔸 Organisation des fichiers de test

Tous les tests sont placés dans le dossier /test et respectent la hiérarchie de lib/ :

test/ ├── core/ │ └── ia_master/ │ └── unit/ ├── modules/ │ └── sante/ │ ├── widget/ │ └── integration/ 

🔸 Convention de nommage

Fichiers : module_name_test.dart (ex. : ocr_service_test.dart, education_card_test.dart)

Préfixes : unit/, widget/, integration/

Contenu : un fichier de test = un groupe de fonctionnalités testées logiquement liées

⏱️ Chapitre 5 — Routine de développement conseillée

Cette routine simple permet de garder un développement fluide, propre, et bien testé sans perte de temps ni oubli.

🔁 Étapes quotidiennes à suivre :

Créer la fonctionnalité dans un module ou le noyau

Ajoute les fichiers .dart dans lib/modules/... ou lib/core/...

Lancer le script generate_test_module.dart

Crée automatiquement tous les fichiers de test nécessaires (unit/widget/integration)

Coder les tests de base pour la nouvelle fonctionnalité

Même minimal, un test permet de documenter et vérifier ton code

Lancer localement les tests

flutter test 

Commit clair avec nom de la fonctionnalité
Exemple :

git commit -m "feat: ajout export PDF carnet santé + tests" 

Push vers GitHub

Lance automatiquement les tests + met à jour le fichier test_tracker.md

Mise à jour du suivi si c’est une étape importante

Ajouter dans le fichier noyau_suivi.md ou suivi_taches.md la ligne correspondante

Cette méthode te permet de garder une vision claire de l’avancement et de minimiser les oublis tout en profitant des automatisations.

⚡️ Chapitre 6 — Connecter ton IA de développement

L’IA de développement dans AniSphère est un ensemble d’outils intelligents conçus pour automatiser, surveiller, corriger et enrichir ton travail en temps réel.

Elle est divisée en 3 niveaux :

🧠 1. IA copilote (GitHub Copilot + ChatGPT)

Copilot → complète automatiquement le code, propose du refactoring, génère des widgets, classes et fonctions

ChatGPT (via projet AniSphère) → lit, optimise et restructure tous les fichiers (Markdown, Dart, PDF)

Sert aussi de planificateur, d’auditeur de code, de moteur de génération IA personnalisé

⚙️ 2. Automatisation IA (test tracker + GitHub Actions)

Met à jour automatiquement : 

les tests manquants (update_test_tracker.dart)

les suivis Markdown (*_suivi.md, test_tracker.md)

les résultats de test (flutter_tests.yml)

Alerte lorsqu’un fichier n’a pas de test associé ou si une fonctionnalité semble oubliée

🧬 3. IA maîtresse de développement (interne au noyau — en cours de développement)

Diagnostique les lenteurs, bugs, erreurs d’architecture

Corrige ou suggère automatiquement des patchs intelligents

Anticipe les conflits ou les duplications dans les modules

Optimise la structure du code au fur et à mesure de l’évolution du projet

À venir :

Score d’intelligence du projet (qualité, modularité, couverture test)

Analyse IA de la charge Firebase en temps réel

Tableau de bord IA de performance technique globale (invisible utilisateur)

🧠 Chapitre 7 — Supervision & Contrôle Global de l’Application

Le Super Admin (toi, le propriétaire et développeur d’AniSphère) dispose d’un accès complet et exclusif à une interface de supervision étendue.

🎯 Objectifs de cette supervision :

Suivre l’état du noyau, des modules, de l’IA et des utilisateurs

Contrôler les synchronisations, les performances, les tests

Déclencher des actions manuelles (debug, purge, réactivation...)

Vérifier les remontées Firebase / Hive / IA / logs / erreurs

🔐 Accès Super Admin

Caché dans les paramètres → triple-tap sur la version AniSphère

Accès sécurisé avec code maître ou validation biométrique (optionnel)

Interface uniquement disponible localement ou sur appareils autorisés

🔍 Informations accessibles

Statistiques anonymisées (usage modules, fréquence, types animaux)

État des tests et couverture (test_tracker.md en temps réel)

Charge Firebase / Hive / synchronisations en différé

Liste des erreurs et bugs récents (auto-loggés)

Suivi IA maîtresse : décisions prises, données analysées, IA locales utilisées

🛠️ Actions possibles

Forcer la désactivation d’un module

Corriger une entrée corrompue ou mal synchronisée

Réinitialiser une IA locale bloquée

Lancer un scan complet du projet (optimisation IA + tests)

🧬 IA en lien avec cette supervision

Résumé automatique hebdomadaire dans l’interface

Suggestions de simplification (code, UX, modules)

Alerte si un module est trop coûteux ou inutilisé

🧰 Chapitre 8 — Outils personnalisés à intégrer

Voici une liste d’outils, scripts et automatismes à mettre en place progressivement pour accélérer et fiabiliser le développement d’AniSphère.

🔁 Scripts existants

generate_test_module.dart → Génère les tests automatiquement (unit/widget/integration)

seed_scheduler_config.dart → Crée la configuration de planification dans Firestore

update_test_tracker.dart → Met à jour la checklist de couverture de tests (test_tracker.md)

flutter_tests.yml → GitHub Actions : lance les tests à chaque push

update_test_tracker.yml → GitHub Actions : met à jour la checklist à chaque push
firestore_verification.dart → Vérifie la connexion Firestore
seed_firestore.dart → Insère des données de démonstration (support, messages, subscriptions)
train_ia_pipeline.py → Entraîne les modèles IA localement et produit un package .zip
upload_model_to_functions.sh → Copie le package dans `functions/` pour déploiement Firebase

### Exécution des scripts Firestore

Assure-toi d'avoir configuré Firebase (`flutterfire configure`).
Lance ensuite : `dart run scripts/seed_firestore.dart`

### Scripts IA Python
Installez les dépendances : `pip install firebase-admin pandas scikit-learn`.
Ce fichier requiert une clef de service Firebase dans `scripts/serviceAccountKey.json`.
Lancez ensuite :
`python scripts/ia/run_training_pipeline.py <categorie> --service-account scripts/serviceAccountKey.json`



🚀 Outils à ajouter (roadmap IA & Dev)

generate_module_skeleton.dart → Crée l’ossature complète d’un nouveau module (models/, screens/, services/, tests/)

analyze_firebase_costs.dart → Analyse les appels Firebase par module pour détecter les points coûteux

optimize_hive_usage.dart → Détecte les entrées inutiles ou redondantes dans la base locale

ia_log_summarizer.dart → Résume chaque semaine les décisions prises par l’IA maîtresse

issue_report_generator.dart → Génère automatiquement un ticket quand une anomalie est détectée (intégration GitHub Projects ou Notion)

✅ Types de tests supplémentaires à systématiser

Tests de connexion / déconnexion / reconnexion automatique

Tests de permissions (caméra, GPS, stockage, etc.)

Tests de sécurité des données locales (chiffrement Hive)

Tests de synchronisation Firebase (envoi différé, conflits)

Tests IA (comportement, suggestions, décisions locales)

Tests UX (onboarding, navigation, retour utilisateur)

🧠 Bonus : IA dev helper (à long terme)

Assistant IA local qui : 

Explique les erreurs de build ou de test

Suggère des refactorings intelligents

Surveille les modules inactifs ou obsolètes

Corrige automatiquement les erreurs simples (hotfix IA)

🚀 Chapitre 9 — Vision long terme & évolutions

AniSphère n’est pas une simple application mais une plateforme complète et évolutive. Ce chapitre pose les bases du développement à long terme pour assurer sa pérennité, son intelligence, et sa rentabilité.

🎯 Objectifs stratégiques à long terme

Créer une architecture ultra modulaire, durable et adaptable
→ Aucun code du noyau ne doit être dupliqué dans les modules

Faire de l’IA un vrai copilote et moteur d’évolution
→ L’IA apprend seule à partir des usages réels et optimise AniSphère sans intervention

Offrir une expérience fluide, addictive et utile
→ Chaque interaction doit apporter une satisfaction ou une utilité mesurable pour l’utilisateur

Devenir un outil incontournable pour le monde animal
→ Refuges, vétérinaires, particuliers, éleveurs, dresseurs, tous doivent s’y retrouver

🧠 Évolutions prévues par l’IA

IA maîtresse capable de :

Analyser la fréquence et la qualité d’usage de chaque module

Optimiser automatiquement le déclenchement ou la désactivation des modules

Rendre compte au Super Admin de l’impact réel des changements

Générer des suggestions d’UX ou de fonctionnalités futures selon l’usage réel

IA dev assistant capable de :

Scanner automatiquement le code, les tests, les performances

Corriger ou suggérer des refactorings à fort impact

Suivre la roadmap et proposer les prochaines priorités intelligemment

📈 Suivi et amélioration continue

Fichier noyau_suivi.md mis à jour automatiquement après chaque push
Consultez [docs/stockage_suivi.md](docs/stockage_suivi.md) pour le suivi du stockage (Hive, Firebase, drives).
Rapport IA hebdomadaire dans l’interface Super Admin avec :

modules à supprimer, à optimiser ou à promouvoir

bugs fréquents

surcoûts Firebase

scores IA de qualité technique

Analyse de rentabilité IA par module :

coût Firebase généré

revenus potentiels

impact utilisateur réel (usage + feedbacks)

Historique des évolutions IA :

Tout apprentissage est journalisé (anonymisé) pour pouvoir justifier les actions

🔄 Objectifs de mise à jour continue

Adapter l’IA à chaque nouvelle fonctionnalité

Faire évoluer les tests et scripts avec les modules

Créer une documentation vivante, lisible par l’IA elle-même

Intégrer des tests de cohérence IA dans le processus de déploiement
























