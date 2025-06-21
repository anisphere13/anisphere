🛑 Restauration version française native — multilingue désactivé le 21/06/2025 via reset sur 9934dbf9.
Toute nouvelle évolution doit être documentée ici jusqu’à la réactivation du multilingue.

📦 stockage_suivi.md — Optimisation du stockage

Ce document décrit le fonctionnement du `StorageOptimizer`. Ce service se charge
 de compresser les images et de calculer un hash afin de détecter les doublons
avant tout envoi vers le cloud.

### Objectifs
- Réduire la taille des fichiers transférés (moins de coût Firebase)
- Éviter l’envoi de fichiers identiques
- Simplifier la préparation des fichiers dans `CloudSyncService` et `CloudDriveService`

### Utilisation basique
```dart
final compressed = await StorageOptimizer.compressImage(file);
final hash = await StorageOptimizer.computeHash(compressed ?? file);
```

Dans `CloudSyncService.pushSupportData`, la liste des pièces jointes est
optimisée via `StorageOptimizer.optimizePaths` avant l’upload. Le futur
`CloudDriveService` appliquera la même logique pour tous les fichiers mis
en ligne.

