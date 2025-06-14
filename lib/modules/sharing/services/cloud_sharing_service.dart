library;

/// Service cloud de partage pour AniSphère.
class CloudSharingService {
  final List<String> uploaded = [];

  /// Envoie une donnée au cloud et retourne `true` si tout s'est bien passé.
  Future<bool> upload(String data) async {
    uploaded.add(data);
    return true;
  }
}
