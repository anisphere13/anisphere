/// Copilot Prompt : Drapeaux IA globaux AniSphère.
/// Contient des booléens de configuration rapide pour activer/désactiver
/// des comportements IA côté client. Utilisé pour debug, test, maintenance.
library;

class IAFlag {
  static bool enableSync = true;
  static bool enableSuggestions = true;
  static bool enableRuleEngine = true;
  static bool enableDebugLogs = true;
  static bool offlineOnly = false;

  /// 🔄 Reset à l'état par défaut
  static void reset() {
    enableSync = true;
    enableSuggestions = true;
    enableRuleEngine = true;
    enableDebugLogs = true;
    offlineOnly = false;
  }
}
