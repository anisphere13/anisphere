🤖 ia_policy.md — Politique IA AniSphère (MAJ 2025)

Ce document récapitule les pratiques IA actuelles. L'IA privilégie l'exécution locale pour préserver la confidentialité et réduire les coûts. Les données utiles sont collectées via un module de métriques puis synchronisées en différé vers le cloud. Les fonctionnalités IA avancées (recommandations, modèles partagés) restent réservées aux comptes premium.

## Principes clés

- **IA locale avant tout** : TFLite et Hive assurent le fonctionnement hors connexion.
- **Collecte de métriques** : `metrics_collector.dart` centralise les scores et retours utilisateur.
- **File de synchronisation offline** : `offline_sync_queue.dart` stocke les logs jusqu'à la prochaine connexion.
- **Fonctionnalités cloud premium** : recommandations et modèles IA complets accessibles via abonnement.

## État actuel et suites prévues

| Principe | Statut actuel | Tâches futures |
|---------|---------------|----------------|
| IA locale prioritaire | Implémentée dans chaque module (voir `7__ia.md`) | Étendre l'analyse comportementale offline |
| Collecte de métriques | `metrics_collector.dart` opérationnel et testé | Générer des rapports détaillés (test à compléter) |
| File de synchronisation offline | Service en cours, tests manquants (`offline_sync_queue.dart`) | Finaliser la mise en place et ajouter les tests listés dans `docs/test_tracker.md` |
| Cloud IA premium | Architecture définie (phase 7 roadmap) | Activer la descente des modèles et la gestion des abonnements |

