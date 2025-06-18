🧠 7__ia.md — Architecture IA AniSphère (MAJ Juin 2025) 

1. Vision & Objectifs 

AniSphère repose sur une architecture IA hybride, optimisée pour : 

Réduire les coûts cloud et l’usage Firebase 

Garantir la confidentialité et la performance offline 

Offrir des capacités d’apprentissage collectif et d’adaptation par module ET par grande catégorie métier 

Permettre une montée en charge progressive de l’IA cloud pour optimiser les coûts à chaque phase du projet 

 
 

2. Organisation générale 

a. IA locale (TFLite/OpenCV/Logique Flutter) 

1 IA locale par module  

Fonctions : OCR, détection d’image, UX intelligente, scoring, analyse comportementale, suggestions, gestion offline, etc.
Un service local (`BehaviorAnalysisService`) récupère les données des capteurs et
exécute un petit modèle TFLite pour suivre l'activité et la posture.

Implémentée en Dart (logic/), ou embarquée via TFLite ou plugin natif 

Enregistre ses propres métriques localement (Hive) et prépare des logs pour le cloud 

Interagit avec IAMaster (noyau) pour la synchronisation, le déclenchement ou la collecte d’informations transverses 

b. IA cloud (par catégorie de modules) 

1 IA cloud par grande catégorie  

Catégories principales :  

Santé (ex : analyse carnet santé, suivi santé animale, prédiction de risques) 

Éducation (ex : suggestions d’exercices, analyse de progression, scoring éducatif) 

Dressage (ex : pistage GPS, analyse d’entraînement, scoring, conseils experts) 

Communauté (ex : réputation, modération, matching d’adoption) 

Pro/Structure (ex : gestion multi-compte, scoring pro, CRM vétérinaire…) 

Fonctions :  

Apprentissage global, consolidation de métriques, détection d’anomalies, suggestion intelligente, entraînement de modèles mutualisés 

Réception des données anonymisées de tous les modules de la catégorie 

Descente des recommandations, plans, modèles IA à tous les utilisateurs de la catégorie (premium ou sur demande) 

Techno : Python (FastAPI, Flask), Node.js, Firebase Functions, Vertex AI, TensorFlow, PyTorch, etc. 

c. IAMaster (noyau, local + cloud) 

Superviseur général de l’IA  

Orchestration des échanges module/local ↔ cloud ↔ utilisateur 

Planification des sync, contrôle des quotas, optimisation des flux (compression, différé, batching, anonymisation) 

Sécurité : IAMaster veille au respect RGPD, filtre les données, déclenche la descente IA seulement pour premium 

Peut centraliser les logs, les incidents IA, et les corrections automatiques 

 
 

3. Pipeline IA : Collecte → Traitement → Synchronisation → Feedback 

Collecte locale 

Chaque IA locale enregistre ses données, scores, feedbacks utilisateur dans Hive (local_storage_service, metrics_collector) 

Prépare les données pour la sync cloud (via OfflineSyncQueue, CloudSyncService) 

Sync vers IA cloud 

IAMaster orchestre la montée des données vers la bonne IA cloud de catégorie (CloudSyncService.pushCategoryData("sante", ...)) 

Upload toujours en batch compressé, jamais en temps réel sauf nécessité critique 

Stockage cloud initial (SANS apprentissage IA activé) 

Au lancement de l’application, toutes les données sont bien stockées dans le cloud (Firestore, BigQuery…), mais aucun apprentissage IA n’est lancé par défaut. 

L’apprentissage IA cloud est explicitement déclenché “au clic” par le superadmin via une interface dédiée, pour maîtriser les coûts d’infrastructure. 

Cette approche permet de constituer un jeu de données propre, validé, analysé, avant de lancer tout pipeline IA gourmand en ressources/cloud. 

Activation progressive de l’apprentissage IA cloud 

Lorsque la base utilisateurs ou le volume d’abonnements le justifie (décision manuelle ou automatique par IAMaster/cloud), le superadmin peut déclencher l’apprentissage régulier (batch/scheduled). 

L’IA cloud peut alors apprendre sur toutes les données déjà collectées, et continuer de s’entraîner de façon régulière à mesure que le volume et les revenus augmentent. 

Optimisation continue : IAMaster cloud peut ajuster la fréquence ou l’intensité de l’apprentissage en fonction des coûts, de la demande, ou du statut premium de la base utilisateurs. 

Traitement IA cloud 

L’IA cloud de la catégorie reçoit, apprend, met à jour ses modèles, détecte tendances/anomalies 

Peut renvoyer feedback, recommandations, ou updates modèles via IAMaster (si premium) 

Descente IA 

Les recommandations, plans, modèles ou MAJ IA sont proposées uniquement aux comptes premium ou sur action de l’utilisateur 

IAMaster gère la descente, applique ou notifie les modules concernés 

 
 

4. Sécurité, RGPD & Coût 

Aucune donnée sensible ne transite dans l’IA cloud (tout est anonymisé dès la collecte)
L'anonymisation est réalisée par le service `AnonymizationService` qui hache les identifiants avant tout envoi (voir ci-dessous).

Sync batch différée et compressée pour optimiser les coûts Firebase

Logs, consentements, et scorings toujours versionnés et consultables 

Sync descendante réservée au premium (freemium IA) 

IAMaster assure l’explicabilité IA (toutes les décisions IA doivent être traçables)

Maîtrise totale des coûts IA cloud : apprentissage déclenché uniquement manuellement par le superadmin au lancement, puis progressivement selon le business model (abonnements/usage)

### Anonymisation des données

Le service `AnonymizationService` prépare les modèles avant leur synchronisation. Il retire ou hache les identifiants personnels (IDs, email, téléphone) pour qu'aucune information sensible ne soit stockée dans le cloud ou dans les files offline.

 
 

5. Implémentation technique 

lib/modules/noyau/logic/

ia_master.dart : superviseur général 

ia_executor.dart : exécution locale des décisions IA 

ia_scheduler.dart : planification et déclenchements périodiques 

lib/services/ia/ia_metrics_collector.dart : collecte, structuration et upload des métriques IA

offline_sync_queue.dart : stockage différé des logs/metrics
offline_photo_queue.dart : file d'attente des photos hors ligne (pré-analyse IA puis upload différé)
offline_gps_queue.dart : stockage des traces GPS offline, analyse comportementale et sync différée

Ces files offline assurent la capture hors ligne et permettent une pré-analyse IA locale avant l'upload batch au cloud. 

cloud_sync_service.dart : upload batch vers la bonne IA cloud de catégorie 

modules/[module]/logic/  

IA locale de chaque module (TFLite, rules, analyzers)
- Ex. `BehaviorAnalysisService` pour interpréter les pas et la posture

cloud/ (non versionné ici)  

Backend API IA cloud par catégorie (API REST, batch endpoints, ML pipeline) 

Stockage Firestore ou BigQuery par catégorie 

Scripts d’apprentissage, retrain, déploiement modèles

### Gestion des modèles IA locaux

Les modèles embarqués sont rangés dans `lib/modules/noyau/ia_local/`. Ce dossier
contient une sous-arborescence par type de modèle (OCR, comportement, etc.).
Chaque modèle est téléchargé puis stocké dans `ApplicationDocumentsDirectory` à
travers le service `IaModelLoader`. L’utilitaire `IaModelUpdater` vérifie
périodiquement Firebase Storage pour récupérer la dernière version disponible.
Si la connexion échoue ou qu’aucun modèle n’est publié, l’application continue
d’utiliser la version locale déjà enregistrée ou celle embarquée par défaut.
Les modèles sont donc versionnés pour assurer la compatibilité lors des mises à
jour.

6. Structure Firestore / Backend recommandée

/ia_categories/{categorie}/uploads 
/ia_categories/{categorie}/models 
/ia_categories/{categorie}/feedbacks 
/users/{userId} 
/animals/{animalId} 
/modules/{moduleName}/ 
/logs_ia/{categorie}/ 
/consents/ 
 

 
 

7. Extension & Maintenance 

Ajout d’un module : crée son IA locale, déclare sa catégorie, raccorde CloudSyncService à la bonne IA cloud 

Ajout d’une IA cloud : crée un nouveau backend/API de catégorie, ajoute la logique IAMaster correspondante 

Versionning : tous les modèles IA (locaux et cloud) sont versionnés et updatables 

Tests & Explicabilité : chaque décision IA doit être traçable et testable (via test_tracker.md) 

 
 

8. Roadmap & Suivi 

Déploiement de l’IA cloud “Santé” et “Éducation” en priorité (roadmap phase 4) 

Ajout progressif des pipelines d’analyse, recommandations, scoring pour chaque catégorie 

Au lancement, stockage cloud sans apprentissage IA — activation manuelle par superadmin, puis apprentissage régulier quand la rentabilité est assurée (abonnements actifs) 

Activation progressive de la descente IA premium sur demande ou par abonnement 

Mise à jour régulière du fichier 7__ia.md à chaque avancée majeure 

 
 

Cette architecture IA garantit à AniSphère : 

Performance, confidentialité, évolutivité, optimisation des coûts 

Facilité d’extension pour de futurs modules ou catégories IA 

Contrôle total sur le lancement, la montée en charge et la rentabilité de l’IA cloud 