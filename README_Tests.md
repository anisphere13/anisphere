✅ README — Tests automatiques & suivi de développement

Ce dossier centralise tous les outils, scripts et bonnes pratiques pour assurer un suivi rigoureux et automatisé du développement de l’application AniSphère.

📁 Structure recommandée des tests

Chaque module (y compris le noyau) doit avoir :

unit/

Tests des modèles, services, classes de logique métier

Exemple : animal_model_test.dart, firebase_service_test.dart

widget/

Tests des composants visuels indépendants

Exemple : login_screen_test.dart, animal_card_test.dart

integration/

Tests des flux utilisateur complets

Exemple : création d’un animal, ajout d’une note, navigation avec ou sans connexion

🧪 Types de tests obligatoires par fonctionnalité

Modèles (.dart) : tests unitaires pour valider la structure, la sérialisation, et la logique métier.

Interfaces utilisateur : tests widgets pour vérifier les affichages, états, et interactions.

Navigation et flux utilisateur : tests d’intégration pour valider les parcours complets.

Notifications : test unitaire de la logique et test d’intégration pour l’affichage.

Connexion et authentification : test widget et test d’intégration pour toutes les variantes (email, Google, Apple) et erreurs.

IA / API : test unitaire avec mocks pour simuler les réponses et tester la prise de décision.

UX critiques : tests widget + tests utilisateurs sur les animations, messages, feedbacks, et fonctionnement hors ligne.

⚙️ Scripts inclus

generate_test_module.dart : génère automatiquement la structure de tests pour un nouveau module

update_test_tracker.dart : met à jour le fichier docs/test_tracker.md avec le statut des tests

✅ Suivi automatique (GitHub Actions)

flutter_tests.yml : exécute tous les tests à chaque push et produit un rapport de couverture

update_test_tracker.yml : met à jour automatiquement test_tracker.md, détecte les fichiers sans test ou en erreur

🧠 Suggestions IA (à venir)

Intégration d’une IA de développement : 

Analyse automatique du code non couvert

Propositions de fichiers de test générés automatiquement

Détection de logique complexe sans couverture

📋 Suivi manuel complémentaire

Lorsqu’un fichier est modifié sans test, un commentaire TODO doit être ajouté dans le fichier

Ce commentaire est remonté automatiquement dans test_tracker.md

Souhaites-tu maintenant un exemple complet de structure de test pour un module (fichiers + modèles de test) ?


