✅ Suivi de développement — Noyau d’AniSphère

Ce document suit de manière détaillée la conception, le développement, les tests et les validations du noyau central de l’application AniSphère. Il sert de tableau de bord interne, maintenu à jour au fil de l’avancement du projet.

🔹 Phase 1 — Mise en place du noyau minimal fonctionnel

Objectifs :

Créer l’ossature de l’application avec gestion locale (Hive) et Firebase

Implémenter les comptes utilisateurs, la base des animaux, et la structure modulaire

Préparer la synchronisation cloud et l’IA maîtresse

Tâches principales :

[x] Initialisation Flutter, configuration Firebase, création du projet

[x] Intégration Hive (stockage local sécurisé)

[x] Authentification (email, Google, Apple) avec Firebase Auth

[x] Modèle utilisateur (user_model.dart) et service utilisateur (user_service.dart)

[x] Stockage des utilisateurs dans Hive + Firebase

[x] Création du modèle animal (animal_model.dart) et service associé

[x] Liaison utilisateurs ↔ animaux dans Hive et Firestore

[x] Création du user_provider.dart pour la gestion d’état globale

[x] Écran de démarrage (splash_screen.dart) avec redirection intelligente

[x] UI login/register fonctionnelle et testée (erreurs gérées, UX testée)

[x] Gestion des permissions et rôles utilisateur via les modules

[x] Navigation de base avec les 4 onglets fixes

Résultat :

Statut : Fonctionnel et stable localement (Hive)
Connexion / Inscription / Accès aux animaux opérationnels
Structure modulaire prête pour accueillir les modules externes

🔹 Phase 2 — Développement de l’IA maîtresse & optimisation globale

Objectifs :

Mettre en place l’IA maîtresse centrale du noyau

Optimiser les performances, la consommation Firebase et la fluidité UX

Intégrer le début de la maintenance IA

Tâches principales :

[x] Création de la structure IA (lib/core/ia_master/)

[x] Système de suggestions intelligentes (modules, rappels, actions UX)

[x] Compression des données à la volée avant envoi Firebase

[x] Ajout des premiers logs IA (temps d’ouverture, navigation, interactions modules)

[x] Optimisation de la synchronisation différée : triggers par action seulement

[x] Implémentation du tri des données avant upload Firebase

[x] Début de la maintenance IA locale : purge, relance de module bloqué

Suggestions d’amélioration IA :

[ ] Ajout d’un moteur d’analyse comportementale IA local (usage, abandon, interactions inutiles)

[ ] Création d’une fonction d’évaluation de rentabilité (coût Firebase vs bénéfice UX)

[ ] Rendre l’IA maîtresse paramétrable dans les réglages développeur (niveaux d’agressivité, fréquence de scan)

Résultat :

Statut : IA maîtresse initialisée, active et fonctionnelle
Les premières optimisations IA sont effectives et testées
La maintenance intelligente commence à détecter et corriger les incohérences simples

🔹 Phase 3 — Modules essentiels & expérience utilisateur guidée

Objectifs :

Activer les modules essentiels dans l’interface

Structurer l’expérience guidée au premier lancement (UX)

Finaliser les briques de base nécessaires à l’ouverture au public

Tâches principales :

[x] Ajout du magasin de modules (lib/core/modules_registry/)

[x] Activation / désactivation dynamique de chaque module

[x] Gestion des permissions par module (caméra, GPS, stockage, etc.)

[x] IA de recommandation de modules selon profil utilisateur et type d’animaux

[x] Interface guidée au premier lancement (onboarding IA + OCR carnet santé)

[x] Génération automatique des données vétérinaires à partir de l’OCR

[x] Liaison automatique des modules installés aux animaux existants

Suggestions UX & IA :

[ ] Ajouter une analyse IA des modules non utilisés pour proposer une désactivation

[ ] Mettre en place un "mode test" IA pour les nouveaux utilisateurs (tutoriel intelligent)

[ ] Ajouter une IA de priorisation visuelle dans l’interface (panneaux colorés, urgences, alertes)

Résultat :

Statut : L’application est prête à l’usage avec navigation complète, modules activables, et interface IA guidée.
Le noyau est officiellement connecté à tous les modules prioritaires (santé, éducation, partage).

🔹 Phase 4 — Monétisation et expansion

Objectifs :

Mettre en place les briques de monétisation du noyau

Activer le module Communauté et les fonctionnalités liées aux services

Étendre la portée du noyau avec les premières API et interconnexions web

Tâches principales :

[x] Mise en place de la gestion des abonnements (gratuits, premium, par module)

[x] Liaison entre les modules payants et le magasin central (avec test IA de conversion)

[x] Interface utilisateur pour suivre son niveau d’abonnement, options actives, et rôles

[x] Intégration du module Communauté : liens directs avec les animaux et le profil utilisateur

[x] Création d’une base de services communautaires (entraide, garde, sphères…)

[x] Déploiement des premiers liens API web (profil public d’animal, page de fugue…)

[x] Ajout du site compagnon dynamique lié au noyau (présentation modules, statistiques, alertes partagées)

Idées d’optimisation économique :

[ ] IA d’évaluation automatique de la rentabilité d’un module (temps passé / coût / conversion)

[ ] Système d’essai gratuit intelligent pour les modules payants selon profil (ex : 7 jours pour pro)

[ ] Recommandation IA de modules premium selon la fréquence d’usage et historique

Résultat :

Statut : L’application est maintenant prête à générer des revenus via les modules, les services, et les extensions.
Le noyau intègre une vision long terme de la rentabilité, sans alourdir l’expérience gratuite.

🔹 Phase 5 — Autonomisation & supervision intelligente par l’IA

Objectifs :

Déléguer au maximum la gestion, la correction et l’optimisation du système à l’IA maîtresse.

Mettre en place une IA capable d’apprendre de manière continue et d’agir automatiquement dans l’application.

Intégrer la supervision continue dans le tableau de bord du Super Admin.

Tâches clés :

[ ] Création d’un module de diagnostic IA (vérification des lenteurs, bugs, fichiers corrompus)

[ ] Mise en place d’une IA auto-correctrice (patch automatique des erreurs simples)

[ ] Journalisation automatique des décisions de l’IA (explication + horodatage)

[ ] Visualisation dans l’interface Super Admin des alertes, interventions, et suggestions IA

[ ] Scoring IA hebdomadaire : qualité technique, modularité, usage, erreurs

[ ] Optimisation automatique des performances (analyse Firebase, synchronisation Hive, compression fichiers)

[ ] Intégration d’un système de refactoring IA assisté (proposition de simplification du code ou architecture)

Résultat attendu :

Une application semi-autonome, résiliente, auto-réparatrice, qui informe le développeur plutôt qu’elle ne dépend de lui.
Le noyau d’AniSphère devient un écosystème vivant, guidé par une IA transparente, efficace et éthique.

🔹 Phase 6 — Sécurité renforcée & confidentialité des données

Objectifs :

Renforcer la sécurité locale et cloud de l’application pour assurer la confiance des utilisateurs.

Protéger les données sensibles tout en gardant la synchronisation intelligente active.

Tâches clés :

[ ] Implémentation du chiffrement complet des données sensibles (local Hive + Firebase)

[ ] Séparation stricte des données sensibles vs analytiques (via IA + marquage)

[ ] Ajout d’un système de rôles hiérarchisés (module par module + compte principal)

[ ] Intégration de permissions dynamiques (modifiables selon le profil et l’usage)

[ ] Authentification avancée (biométrie, code secondaire, double validation)

[ ] Mode hors-ligne chiffré avec délai d’autodestruction (ex. 30 jours inactif non sync)

Résultat attendu :

Une application à la fois sécurisée et fluide, où la confidentialité est intégrée nativement à l’architecture. Les utilisateurs restent maîtres de leurs données, et l’IA ne retient que ce qui est autorisé.

🔹 Phase 7 — Interopérabilité & API externe

Objectifs :

Rendre AniSphère compatible avec les outils vétérinaires, les refuges, et les services externes.

Créer une API privée et sécurisée pour permettre l’échange de données en toute maîtrise.

Tâches clés :

[ ] Définir une structure d’exportation standardisée (carnet santé, modules, historique IA, identité animal)

[ ] Création d’un API REST (avec clés d’accès personnalisées et scopes de permission)

[ ] Intégration des standards vétérinaires existants (format de carnet, vaccins, prescriptions)

[ ] Possibilité d’envoi automatique ou validé par l’utilisateur (PDF, JSON, synchronisation directe)

[ ] Interface IA de gestion des connexions externes (tableau de bord des liens, alertes de conflit)

[ ] Journalisation de tous les échanges pour traçabilité

[ ] Compatibilité future avec un connecteur web ou logiciel vétérinaire (module pro dédié)

Résultat attendu :

Une application ouverte, interopérable, mais sécurisée, qui permet aux vétérinaires, refuges ou partenaires d’interagir avec les données AniSphère sans jamais compromettre la confidentialité. L’IA assure la traçabilité et le contrôle total des flux entrants et sortants.

🔹 Phase 8 — Monétisation avancée & modules premium intelligents

Objectifs :

Mettre en place une stratégie de monétisation transparente, efficace et équitable.

Optimiser les revenus en fonction de l’usage réel et du profil utilisateur.

Utiliser l’IA pour piloter dynamiquement l’offre premium sans frustrer l’utilisateur.

Tâches clés :

[ ] Création d’un système d’abonnement modulaire (par utilisateur, par module, ou bundle global)

[ ] Définition de modules gratuits vs modules premium selon les besoins fondamentaux

[ ] Ajout d’une IA d’analyse revenu/coût par fonctionnalité (ex : IA santé, export PDF, synchronisation externe)

[ ] Système de paiement intégré (Google/Apple Pay, carte, coupon, parrainage…)

[ ] Mise en place de modules à activation temporaire (essai gratuit, achat unique, crédit interne "Sphères")

[ ] Génération automatique d’un score d’utilité IA → Modules recommandés ou inutilisés

[ ] Tableaux de bord revenus/usage disponibles pour le Super Admin

Résultat attendu :

Un système de monétisation intelligent, fluide, au service de l’expérience utilisateur. L’IA maximise les revenus sans nuire à la confiance ou à l’usage, tout en maintenant une base gratuite fonctionnelle et utile. Les utilisateurs ont la sensation de payer pour des fonctionnalités vraiment utiles et adaptées à leur besoin.

🔹 Phase 9 — Synchronisation multi-appareils & QR ID

Objectifs :

Permettre aux utilisateurs de synchroniser leur compte et leurs animaux sur plusieurs appareils.

Faciliter le partage de profils via QR code ou identifiant unique sécurisé.

Tâches clés :

[ ] Génération d’un identifiant unique utilisateur chiffré (non lié au nom/prénom)

[ ] Création d’un QR code de synchronisation à usage unique (connexion multi-appareil)

[ ] Ajout d’un bouton "ajouter ce compte à cet appareil" avec validation IA

[ ] Gestion des droits d’accès par appareil (lecture seule, lecture/écriture, admin)

[ ] Synchronisation automatique ou différée des données entre appareils

[ ] Compatibilité avec Google Drive / iCloud / NAS personnel Synology

[ ] Journalisation des connexions et synchronisations (local + cloud sécurisé)

Résultat attendu :

Une expérience multi-supports fluide et sécurisée, idéale pour les foyers, les professionnels ou les utilisateurs multi-devices. La synchronisation reste sous contrôle total de l’utilisateur, l’IA gère les conflits, et aucune donnée sensible ne circule sans autorisation explicite.

🔹 Phase 10 — Infrastructure cloud évolutive & mode professionnel

Objectifs :

Préparer AniSphère à une montée en charge massive (centaines de milliers d’animaux / utilisateurs).

Intégrer un mode professionnel pour les refuges, cabinets, associations ou éleveurs.

Tâches clés :

[ ] Optimisation du stockage Firebase (sharding, compression, suppression intelligente)

[ ] Déploiement d’un serveur complémentaire dédié (Node.js + PostgreSQL ou équivalent scalable)

[ ] Mode "infrastructure hybride" (cloud Firebase + cloud privé + stockage local)

[ ] Création d’un dashboard professionnel (multi-animaux, multi-compte, statistiques IA avancées)

[ ] Système de facturation automatisée selon le nombre d’animaux, modules, synchronisations, IA utilisées

[ ] Ajout d’un mode écosystème étendu pour réseaux de refuges ou de cabinets (liens entre comptes, partage d’animaux)

[ ] Gestion des données multi-utilisateurs (avec rôles par niveau + suivi d’accès)

Résultat attendu :

AniSphère devient un outil professionnel prêt à l’échelle, capable de gérer aussi bien un particulier qu’un réseau de refuges. L’IA aide à répartir les charges, à prioriser les flux, et à garantir la fluidité malgré la croissance.

🔹 Phase 11 — Audit & conformité légale (RGPD, sécurité)

Objectifs :

S’assurer qu’AniSphère respecte les normes légales européennes et internationales (RGPD, CNIL…)

Renforcer la transparence et la responsabilité éthique de l’IA

Tâches clés :

[ ] Séparation stricte des données sensibles (nom, adresse, santé) et données techniques (statistiques, usage)

[ ] Ajout d’un système de consentement progressif (à chaque étape critique)

[ ] Création d’un centre de préférences utilisateur (visualisation et contrôle des données stockées)

[ ] Intégration d’un bouton "supprimer mes données", avec réversibilité limitée (30j)

[ ] Log des accès IA → journalisation de chaque action IA sur des données utilisateur (lecture, suggestion, export)

[ ] Encadrement strict de l’apprentissage IA : anonymisation + contrôle du périmètre autorisé

[ ] Ajout de filtres IA éthiques pour éviter les dérives (discrimination, interprétation sensible, médical non validé)

Résultat attendu :

Une plateforme juridiquement conforme, respectueuse des droits utilisateurs, capable de justifier et retracer toutes ses actions IA. L’éthique est un pilier d’AniSphère, et la confiance des utilisateurs devient un moteur de croissance à long terme.

🔹 Phase 12 — Optimisation IA en temps réel (suivi comportemental + prédiction)

Objectifs :

Permettre à l’IA de détecter, apprendre et prédire les comportements ou besoins des animaux en temps réel.

Déployer un système d’IA auto-adaptatif qui affine ses recommandations au fil des données.

Tâches clés :

[ ] Intégration d’une IA locale embarquée (TensorFlow Lite) pour : 

Analyse des mouvements, habitudes, réactions

Détection d’anomalies comportementales (manque d’activité, anxiété, boiterie…)

[ ] Synchronisation intelligente avec le cloud pour apprentissage collectif (avec anonymisation des données)

[ ] Ajout d’un tableau de prédictions comportementales dans le profil de l’animal

[ ] IA prédictive : suggestions d’actions, de soins ou de modules ("activité en baisse → proposer promenade ou éducation")

[ ] Intégration dans le module vétérinaire : IA alerte en cas de suspicion de problème médical

[ ] Historique IA : journal des comportements détectés / prédits / suivis

[ ] Option de validation manuelle par l’utilisateur pour affiner l’apprentissage

Résultat attendu :

Une IA proactive, personnalisée et préventive, capable d’alerter, conseiller et accompagner l’utilisateur au quotidien. AniSphère devient un assistant animalier intelligent, réactif, et utile même sans intervention manuelle.

🔹 Phase 13 — IA collaborative & apprentissage communautaire

Objectifs :

Créer une IA qui apprend collectivement des utilisateurs d’AniSphère tout en respectant la confidentialité.

Utiliser les retours, les usages et les comportements pour améliorer l’application globalement.

Tâches clés :

[ ] Mise en place d’un système de feedback utilisateur intégré (rapide, contextuel, anonyme si souhaité)

[ ] Centralisation des retours utilisateurs + comportements récurrents pour nourrir l’IA cloud

[ ] IA communautaire capable de détecter des modèles collectifs (efficacité d’un module, fréquence de problèmes, etc.)

[ ] Création d’un score d’apprentissage collectif → sert à prioriser les évolutions du produit

[ ] Génération automatique de suggestions d’amélioration à partir de la base d’utilisateurs (ex : "80% des utilisateurs quittent le module X avant la fin")

[ ] Détection de besoins non couverts et proposition automatique de nouveaux modules

[ ] Classement des modules par impact collectif réel, analysé par l’IA

Résultat attendu :

Une IA collective, évolutive et démocratique, qui s’adapte à son public en permanence. Les utilisateurs ont le sentiment de contribuer à un écosystème utile et en amélioration constante. L’IA devient le reflet des besoins réels de la communauté, sans jamais exposer les données personnelles.


🔹 Phase 14 — IA spécialisée par espèce, race ou contexte

Objectifs :

Adapter le comportement de l’IA en fonction de l’espèce, la race, le mode de vie ou le contexte géographique de l’animal.

Créer des profils IA personnalisés pour une précision maximale dans les recommandations.

Tâches clés :

[ ] Création de modèles IA spécialisés (ex : chien, chat, cheval, NAC)

[ ] Affinage du profil par race, gabarit, âge, activité, climat, environnement (urbain, rural)

[ ] IA contextuelle : 

Suggestions d’activités adaptées au climat local (ex : "trop chaud pour courir")

Conseils d’alimentation ou de soins selon l’âge ou la race

Fréquence de rappel vaccinal ajustée par zone géographique

[ ] Intégration des référentiels vétérinaires nationaux pour chaque espèce

[ ] IA capable de proposer les modules les plus pertinents selon l’espèce ou le profil (éducation, santé, activité)

[ ] Journalisation IA par espèce/race pour apprentissage collectif ciblé

Résultat attendu :

Une IA ultra-ciblée, qui comprend la spécificité de chaque animal et adapte l’app à son quotidien. Cela renforce l’efficacité, la fidélité des utilisateurs et la pertinence globale de l’écosystème AniSphère.

🔹 Phase 15 — Système de retours utilisateurs & IA d’évolution produit

Objectifs :

Centraliser les retours, idées, bugs, et suggestions directement dans l’application.

Mettre en place une IA capable de trier, catégoriser et analyser les retours pour nourrir la roadmap automatiquement.

Tâches clés :

[ ] Création d’un bouton contextuel de retour (dans chaque module ou écran)

[ ] Classification automatique par IA : idée / bug / amélioration / interface / module concerné

[ ] Ajout d’un tableau de bord IA des retours dans l’interface Super Admin

[ ] Possibilité d’envoi anonyme ou attaché à un compte (rôle/espèce visible si besoin)

[ ] Historique de retours (et réponses IA ou patchs liés)

[ ] Liaison automatique avec GitHub ou Notion (ticket ou tâche générée)

[ ] Intégration d’une carte des retours par module → volume, type, satisfaction, fréquence

Optionnelle : version enrichie côté utilisateur

Votes sur les idées populaires (dans le module Communauté)

Réponses visibles ou évolutions notifiées (ex : "votre suggestion a été intégrée dans la mise à jour 1.3.2")

Statistiques communautaires anonymisées disponibles (top idées, bugs, suggestions par espèce…)

Résultat attendu :

Un système proactif, transparent et évolutif, où chaque utilisateur devient contributeur du projet. L’IA extrait les priorités, corrige les bugs et améliore AniSphère en continu, tout en maintenant un lien direct entre les besoins du terrain et les évolutions de l’application.






- 🧩 Synchronisation automatique du noyau le 2025-04-05 ### ✅ user_model.dart
- 📁 `lib/modules/noyau/models/user_model.dart`
- Test : `user_model_test.dart`
- Description : Modèle utilisateur complet (Hive + Firebase), IA-compatible
- Optimisé pour l’IA maîtresse, les rôles dynamiques et le suivi comportemental
- Ajout méthode `copyWith`, `toJson`, `fromJson`, `updateTimestamp`
- Date : 2025-04-06
### ✅ user_service.dart
- 📁 `lib/modules/noyau/services/user_service.dart`
- Test : `user_service_test.dart`
- Description : Service Firebase + Hive, mise à jour IA-ready
- Intègre `getUserFromFirebase`, `syncUserData`, `updateUserFields`, suppression et initialisation différée
- Refactor complet pour le noyau AniSphère
- Date : 2025-04-06
### ✅ user_provider.dart
- 📁 `lib/modules/noyau/providers/user_provider.dart`
- Description : Provider Flutter pour état utilisateur global
- Gère : Connexions, MAJ, sync Hive/Firebase, logout, écoute UI
- Préparé pour : tests unitaires + future IA UX
- Date : 2025-04-06

### ✅ auth_service.dart
- 📁 `lib/modules/noyau/services/auth_service.dart`
- Description : Service central d’authentification Firebase
- Méthodes : connexion (email, Google, Apple), inscription, logout, reset
- Préparé pour tests unitaires (injection `FirebaseAuth`, `UserService`)
- Date : 2025-04-06
### ✅ app_initializer.dart
- 📁 `lib/modules/noyau/services/app_initializer.dart`
- Description : Initialise Firebase et Hive de façon sécurisée
- Gestion : Web, erreurs, boîtes locales, logs IA-ready
- Testable : oui (via mocks ou test indirect)
- Date : 2025-04-06
### 🔄 auth_provider_test.dart (préparation)
- 📁 `test/noyau/unit/auth_provider_test.dart`
- Description : Regroupe tous les mocks nécessaires pour tests avancés (auth, user, box)
- À exécuter avec build_runner pour générer les mocks
- Prochaine étape : écrire les tests pour `auth_service`, `user_provider`
- Date : 2025-04-06
### ✅ firebase_service.dart
- 📁 `lib/modules/noyau/services/firebase_service.dart`
- Description : Service Firebase Firestore pour lecture/écriture des utilisateurs et animaux
- Méthodes : saveUser, getUser, deleteUser, saveAnimal, getAnimal, deleteAnimal, signOut
- Utilisé par : user_provider, animal_service, modules IA
- Test unitaire simple OK
- Date : 2025-04-06
### ✅ animal_model.dart
- 📁 `lib/modules/noyau/models/animal_model.dart`
- Description : Modèle de base des animaux (Hive + Firebase)
- Champs : id, nom, espèce, race, image, timestamps, ownerId
- Test : toJson/fromJson, copyWith
- IA-compatible, structuré pour module identite/ et IA comportementale
- Date : 2025-04-06
### ✅ animal_service.dart
- 📁 `lib/modules/noyau/services/animal_service.dart`
- Description : Service des animaux (Hive + Firebase)
- Gère : sauvegarde locale, synchronisation, suppression
- Utilisé dans le noyau et futur module identite/
- Test unitaire simple OK (mock Hive)
- Date : 2025-04-06
### ✅ splash_screen.dart
- 📁 `lib/modules/noyau/screens/splash_screen.dart`
- Description : Écran de démarrage intelligent. Redirige selon l’état utilisateur.
- Vérifie la session via UserProvider → redirige vers MainScreen ou LoginScreen
- Chargement visuel simple avec message
- Date : 2025-04-06

### ✅ login_screen.dart
- 📁 `lib/modules/noyau/screens/login_screen.dart`
- Description : Formulaire de connexion email / Google / Apple
- Utilise : UserProvider, redirection vers MainScreen
- Inclut gestion d’erreur, chargement et bouton création de compte
- Test manuel (UI) suffisant pour l’instant
- Date : 2025-04-06
### ✅ animals_screen.dart
- 📁 `lib/modules/noyau/screens/animals_screen.dart`
- Description : Affiche la liste des animaux Hive de l’utilisateur
- Utilise : AnimalModel + AnimalService (Hive)
- Prévu pour support ajout animal (FAB)
- Test manuel suffisant pour l’instant
- Date : 2025-04-06
### ✅ register_screen.dart
- 📁 `lib/modules/noyau/screens/register_screen.dart`
- Description : Écran d’inscription utilisateur complet (nom, email, tel, métier)
- Utilise : UserProvider.signUp() → redirige vers MainScreen
- Affiche erreurs, loading, validé manuellement
- Date : 2026-04-06
### ✅ main_screen.dart
- 📁 `lib/modules/noyau/screens/main_screen.dart`
- Description : Interface principale avec les 4 onglets fixes (Accueil, Partage, Modules, Mes Animaux)
- Navigation avec BottomNavigationBar, UI stable
- Utilise : HomeScreen, ShareScreen, ModulesScreen, AnimalsScreen
- Date : 2025-04-12

### ✅ share_screen.dart, home_screen.dart, modules_screen.dart
- 📁 `lib/modules/noyau/screens/`
- Description : Écrans de navigation liés à `MainScreen`
- Contenu simple placeholder pour l'instant, prévus pour extension IA + modules
- Statut : Terminés structurellement, IA-ready
- Date : 2025-04-12

### ✅ splash_screen.dart
- 📁 `lib/modules/noyau/screens/splash_screen.dart`
- Description : Redirige automatiquement selon état utilisateur (connecté ou non)
- Utilise : UserProvider, Firebase, Hive
- Préparé pour futur affichage IA ou messages personnalisés
- Date : 2025-04-12

### ✅ login_screen.dart
- 📁 `lib/modules/noyau/screens/login_screen.dart`
- Description : Formulaire complet avec gestion Google / Apple
- Intégré à UserProvider, redirection auto vers MainScreen
- Gère erreurs et chargement
- Date : 2025-04-12

### ✅ register_screen.dart
- 📁 `lib/modules/noyau/screens/register_screen.dart`
- Description : Formulaire d’inscription complet (nom, mail, tel, métier)
- Liaison avec UserProvider, création compte dans Firebase + Hive
- UX simple, IA-ready
- Date : 2025-04-12

### ✅ local_storage_service.dart
- 📁 `lib/modules/noyau/services/local_storage_service.dart`
- Description : Gère les préférences locales (darkMode, IA, onboarding…)
- Utilise : Hive (box: settings)
- À terme utilisé par IA, UX adaptative, réglages utilisateurs
- Test : accès clé/valeur, fallback
- Date : 2025-04-13

### ✅ ia_master.dart
- 📁 `lib/modules/noyau/logic/ia_master.dart`
- Description : Cœur IA du noyau, centralise les décisions IA
- Méthodes : logEvent, decideUXMode, syncCloudIA, cleanOldLogs
- Gère IA locale + cloud, auto-maintenance, future adaptation UX
- Test : logique décisionnelle IA (UX mode)
- Date : 2025-04-13
### ✅ maintenance_service.dart
- 📁 `lib/modules/noyau/logic/maintenance_service.dart`
- Description : Maintenance automatique du noyau AniSphère
- Méthodes : cleanPreferences, fixHiveIfCorrupted, autoSyncIfExpired
- Appelé au démarrage ou déclenché par IA
- Prépare les outils pour relancer sync / purge Hive si crash
- Test simple possible (non-blocage)
- Date : 2025-04-13

- 🧩 Synchronisation automatique du noyau le 2025-04-13
### ✅ notification_service.dart
- 📁 `lib/modules/noyau/logic/notification_service.dart`
- Permet d'envoyer des notifications locales intelligentes
- Gère l'initialisation FlutterLocalNotifications
- Base prête pour Firebase Messaging (plus tard)
- Appelé depuis IA, Santé, Dressage...
- Test à venir (mock nécessaire)
- Date : 2025-04-13
### ✅ ia_master.dart
- 📁 `lib/modules/noyau/logic/ia_master.dart`
- IA maîtresse : décisions UX, sync cloud, log événementiel
- Simulation de cloud IA
- Base pour toutes les fonctions intelligentes de l’app
- Utilisée dans : splash, user, animaux, santé, IA
- Date : 2025-04-13
### ✅ ia_rules.dart
- 📁 `lib/modules/noyau/logic/ia_rules.dart`
- Contient des règles métiers IA simples (UX, comportement, santé)
- Sert de base aux décisions locales avant IA cloud
- Utilisé dans : onboarding, santé, animal_profile, IA maîtresse
- Date : 2025-04-13
### ✅ ia_config.dart
- 📁 `lib/modules/noyau/logic/ia_config.dart`
- Contient les paramètres IA modifiables (seuils, flags, options UX)
- Sert de base aux règles IA et décisions locales
- Prévu pour compatibilité future avec Remote Config
- Date : 2025-04-13
### ✅ ia_logger.dart
- 📁 `lib/modules/noyau/logic/ia_logger.dart`
- Logger IA isolé pour tracer les événements IA (sync, règles, UX)
- Utilisé par IAMaster et modules IA
- Nettoyage auto intégré
- Date : 2025-04-13
### ✅ ia_rule_engine.dart
- 📁 `lib/modules/noyau/logic/ia_rule_engine.dart`
- Moteur IA qui applique les règles de ia_rules.dart aux animaux
- Retourne des suggestions/action à exécuter (liste de strings)
- Utilisé par IAMaster, modules UX, santé, dressage
- Date : 2025-04-13
### ✅ ia_context.dart
- 📁 `lib/modules/noyau/logic/ia_context.dart`
- Contient le wrapper IAContext (état actuel IA : offline, animaux, etc.)
- Utilisé par IAMaster et IARuleEngine
- Prépare l’enrichissement futur avec IA cloud
- Date : 2025-04-13
### ✅ ia_channel.dart
- 📁 `lib/modules/noyau/logic/ia_channel.dart`
- Définit les canaux IA utilisés pour classer logs, suggestions et alertes
- Sert à trier, visualiser ou exporter les retours IA
- Utilisé dans IAMaster, IALogger, RuleEngine, modules
- Date : 2025-04-13
### ✅ ia_flag.dart
- 📁 `lib/modules/noyau/logic/ia_flag.dart`
- Drapeaux booléens pour activer/désactiver des composants IA localement
- Utilisé pour tests, debug, maintenance, comportement adaptatif
- Date : 2025-04-13
### ✅ ia_chip.dart
- 📁 `lib/modules/noyau/widgets/ia_chip.dart`
- Widget Chip léger représentant un tag IA dynamique
- Utilisé dans l’accueil, dashboard, liste animaux, modules IA
- 100 % réutilisable
- Date : 2025-04-13
### ✅ ia_suggestion_card.dart
- 📁 `lib/modules/noyau/widgets/ia_suggestion_card.dart`
- Widget carte affichant une recommandation IA riche (titre, message, action)
- Utilisé dans l’accueil, dashboard IA, modules
- 100 % réutilisable
- Date : 2025-04-13
### ✅ ia_banner.dart
- 📁 `lib/modules/noyau/widgets/ia_banner.dart`
- Widget bannière IA contextuelle affichée en haut de l’écran
- Sert à indiquer un état IA global ou un message permanent
- Réutilisable dans home_screen, onboarding, profil, dashboard
- Date : 2025-04-13
### ✅ ia_log_viewer.dart
- 📁 `lib/modules/noyau/widgets/ia_log_viewer.dart`
- Widget permettant d'afficher les logs IA locaux (via IALogger)
- Utilisable dans les écrans debug, support, ou IA avancée
- Aide au suivi IA maître et au diagnostic
- Date : 2025-04-13
### ✅ home_screen.dart
- 📁 `lib/modules/noyau/screens/home_screen.dart`
- Écran d’accueil enrichi avec les composants IA :
  - `IABanner` (état IA)
  - `IAChip` (mode IA actif)
  - `IASuggestionCard` (action IA détectée)
  - `IALogViewer` (logs IA)
- IA activée avec IAMaster + IARuleEngine
- Date : 2025-04-13
### ✅ user_profile_screen.dart
- 📁 `lib/modules/noyau/screens/user_profile_screen.dart`
- Description : Affiche les infos personnelles de l'utilisateur + modules actifs
- Préparé pour les stats, QR, export, IA future
- Test UI prévu (widget + logique de déconnexion)
- Date : 2025-04-13
### ✅ settings_screen.dart
- 📁 `lib/modules/noyau/screens/settings_screen.dart`
- Description : Gère les préférences locales (mode sombre, IA suggestions, IA notifications)
- Utilise : LocalStorageService
- Prévu pour extension (langue, compte, export, sync)
- Date : 2025-04-13
