// Copilot Prompt : Drapeaux IA globaux AniSphère.
// Contient des booléens de configuration rapide pour activer/désactiver
// des comportements IA côté client. Utilisé pour debug, test, maintenance.
library;

class IAFlag {
  static bool enableSync = true;
  static bool enableSuggestions = true;
  static bool enableRuleEngine = true;
  static bool enableDebugLogs = true;
  static bool offlineOnly = false;

  // Flag spécifique pour la suggestion d'ajout d'animal (utilisé par l'IA)
  static bool suggestAddAnimal = false;

  // Pour compatibilité avec IAExecutor (si besoin d'un flag de type String)
  static const String showSuggestionCard = "show_ui_suggestion_card";

  /// Méthode statique pour lister tous les flags IA
  static Map<String, bool> getAll() => {
        'enableSync': enableSync,
        'enableSuggestions': enableSuggestions,
        'enableRuleEngine': enableRuleEngine,
        'enableDebugLogs': enableDebugLogs,
        'offlineOnly': offlineOnly,
        'suggestAddAnimal': suggestAddAnimal,
      };

  /// 🔄 Reset à l'état par défaut
  static void reset() {
    enableSync = true;
    enableSuggestions = true;
    enableRuleEngine = true;
    enableDebugLogs = true;
    offlineOnly = false;
    suggestAddAnimal = false;
  }
}
