🧩 Noyau AniSphère — Présentation complète et mise à jour (2025)

1. Rôle central du noyau
Le noyau AniSphère représente la fondation technique de l’application.
Il centralise et gère les services et les fonctionnalités indispensables à tous les modules, permettant ainsi aux modules actifs de se connecter et d’interagir de manière fluide.
 
2. Fonctions principales prises en charge dans le noyau
Le noyau gère toutes les fonctionnalités transverses et critiques nécessaires au bon fonctionnement de l’application. Il permet aux modules d’y accéder et de se connecter facilement via des API standardisées. Voici les grandes catégories gérées par le noyau.

a. Authentification & Gestion des Comptes

Authentification via email/mot de passe, Google, Apple (Firebase Auth).
Gestion des rôles et permissions utilisateur dynamiques.
Préférences utilisateur globales (langue, thème, accessibilité, sécurité).
Support de l'authentification biométrique pour renforcer la sécurité.
Le module superadmin a été déplacé et n’est plus inclus dans le noyau. Il est désormais un module sécurisé indépendant.

b. Gestion des Profils Animaux

Profils détaillés des animaux : nom, sexe, espèce, race, historique.
Modules actifs par animal : chaque animal peut avoir des modules personnalisés (santé, dressage, éducation…).
Intégration avec l’IA locale pour chaque animal (apprentissage, suivi des progrès).
Partage sécurisé des profils animaux (QR code, lien de partage).

c. Stockage hybride, optimisé et chiffré

Stockage local prioritaire via Hive et SQLite, avec chiffrement AES.
Synchronisation cloud différée : Firebase/Firestore en backup, compression des données.
Optimisation des coûts cloud : seule la synchronisation utile est envoyée au cloud.
Mode offline-first : l’application fonctionne sans connexion, avec une synchronisation différée dès que le réseau est disponible.

d. Gestionnaire de modules intelligent

Magasin de modules centralisé : les modules peuvent être activés ou désactivés dynamiquement.
Permissions par module : chaque module déclare ses propres permissions, et le noyau s’assure que les modules n’interfèrent pas entre eux.
Téléchargement intelligent : un module est téléchargé uniquement s’il est activé, limitant ainsi l'empreinte de l’application.

e. Partage, Exports & Traçabilité

Partage sécurisé de profils, documents, ou informations animales via QR code, lien temporaire, ou accès restreint.
Export de documents : PDF, rapports de santé, arbres généalogiques.
Traçabilité des actions utilisateur (qui a partagé quoi, quand, et comment).
Stockage Drive/Dropbox personnel : possibilité pour l’utilisateur de lier son cloud personnel (Google Drive, OneDrive, etc.) pour les exports ou sauvegardes.

f. Notifications & Alertes IA

Notifications locales (offline) et cloud (via Firebase Cloud Messaging).
Gestion de la priorité des notifications (alerte urgente, info régulière, etc.).
Notifications intelligentes : l’IA décide de l’importance et de la fréquence des notifications envoyées à l’utilisateur.
Interface centrale de gestion des notifications pour l’utilisateur et pour les modules.

g. IA maîtresse et intelligence distribuée

Supervision des IA locales : gestion de l’apprentissage et des ajustements en temps réel.
IA locale pour chaque module (éducation, santé, etc.), avec synchronisation vers l’IA maîtresse.
Remontée des données vers l’IA cloud pour enrichir l’apprentissage global.
Optimisation des coûts cloud : seules les données utiles sont synchronisées avec le cloud (batches, compression).

h. Maintenance IA & auto-réparation

Détection des erreurs IA : lorsque l'IA rencontre un bug, l'erreur est remontée et corrigée automatiquement si possible.
Réparation autonome : si une erreur système est détectée, elle est réparée ou contournée sans intervention humaine.
Logs détaillés pour le suivi et l’optimisation des services.

i. Interface UX/Navigation commune

Interface unifiée avec 4 onglets fixes : Accueil, Partage, Modules, Mes Animaux.
Header universel : Notifications, Paramètres, Actions rapides (QR, Synchronisation).
Onboarding IA dynamique : premier démarrage avec tutoriels et assistant pour guider l’utilisateur.
Menu d’actions rapides contextuelles : accès rapide à des actions courantes selon l’état de l’application.

j. Sécurité & Confidentialité

Chiffrement AES local pour toutes les données sensibles.
Confidentialité des informations personnelles : les données sont stockées localement avant toute synchronisation cloud.
Consentement explicite avant toute synchronisation vers Firebase ou autres services cloud.
Gestion des permissions par module : chaque module doit demander et être autorisé par l’utilisateur avant d'accéder à des ressources sensibles (caméra, micro, données personnelles).
 
3. Architecture technique — Résumé
Le noyau est situé dans le répertoire lib/modules/noyau et comprend tous les services de base nécessaires à l’application. Il se compose des sous-dossiers suivants :
auth/ : gestion des comptes, de l'authentification et des rôles utilisateurs.
user/ : gestion des informations utilisateurs (préférences, historique).
animal/ : gestion des profils animaux et de leurs modules actifs.
modules_registry/ : gestion des modules installés, activés, et de leurs permissions.
sync/ : gestion des synchronisations (offline-first, cloud différé, batch).
ia_master/ : supervision de l’IA maîtresse et des IA locales des modules.
notifications/ : gestion des notifications locales et cloud.
sharing/ : gestion du partage sécurisé et des exports.
maintenance/ : détection des erreurs IA et maintenance automatique.
onboarding/ : tutoriel et intégration de nouveaux utilisateurs.
 
4. Évolutivité et modularité
Le noyau fournit une API générique, permettant à chaque module de se connecter facilement à ses services sans avoir à gérer de logique métier spécifique.
Modules : chaque module utilise les services du noyau via une interface simple et claire. Par exemple, un module d’éducation peut utiliser le service de notification pour envoyer des rappels, ou le service de stockage pour enregistrer des données spécifiques à un animal.
Pas de logique métier dans le noyau : le noyau se contente de fournir des services génériques et des API, tandis que chaque module implémente sa propre logique métier (par exemple, les règles de santé ou d'éducation).
Optimisation des coûts : chaque module peut décider s'il souhaite utiliser les services du noyau, ce qui permet de maintenir l'application légère et économique.
 
5. Conclusion
Le noyau AniSphère est le cœur technique de l’application, qui garantit la stabilité, l’évolutivité et l’optimisation des coûts. Il centralise tous les services transverses nécessaires au fonctionnement de l’app, tout en permettant aux modules de se connecter et de personnaliser l’expérience utilisateur sans complexité excessive.
Services robustes et testés dans le noyau (authentification, stockage, IA, notifications…).
Modularité totale : les modules sont responsables de leur propre logique métier, tandis que le noyau gère l’infrastructure, les services essentiels et la sécurité.
Évolutivité : l'architecture est conçue pour ajouter facilement de nouveaux modules sans perturber le noyau ni l'expérience utilisateur.
 

