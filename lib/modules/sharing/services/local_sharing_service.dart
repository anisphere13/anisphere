library;

/// Service local de partage pour AniSphère.
class LocalSharingService {
  final Set<String> _sharedIds = {};

  /// Ajoute un identifiant partagé localement.
  void share(String animalId) {
    _sharedIds.add(animalId);
  }

  /// Vérifie si l'identifiant a déjà été partagé.
  bool isShared(String animalId) => _sharedIds.contains(animalId);
}
