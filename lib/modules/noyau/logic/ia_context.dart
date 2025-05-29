/// Copilot Prompt : Contexte IA local pour AniSphère.
/// Centralise les infos critiques du contexte utilisateur (hors-ligne, animaux, 1er lancement).
/// Permet à IAMaster ou IARuleEngine de prendre des décisions locales intelligentes.

class IAContext {
  final bool isOffline;
  final bool isFirstLaunch;
  final bool hasAnimals;
  final int animalCount;
  final DateTime? lastSyncDate;

  const IAContext({
    required this.isOffline,
    required this.isFirstLaunch,
    required this.hasAnimals,
    required this.animalCount,
    this.lastSyncDate,
  });

  /// 🔁 Construit un IAContext de test par défaut
  factory IAContext.empty() {
    return const IAContext(
      isOffline: false,
      isFirstLaunch: true,
      hasAnimals: false,
      animalCount: 0,
    );
  }

  /// 🔍 Retourne un résumé textuel du contexte
  @override
  String toString() {
    return 'IAContext('
        'offline=$isOffline, '
        'firstLaunch=$isFirstLaunch, '
        'hasAnimals=$hasAnimals, '
        'animalCount=$animalCount, '
        'lastSyncDate=$lastSyncDate'
        ')';
  }
}
