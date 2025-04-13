/// Copilot Prompt : Configuration IA AniSphère.
/// Contient les paramètres de configuration IA (seuils, flags, options actives),
/// modifiables dans le futur via Remote Config.
/// Utilisé par les modules IA, UX adaptative, alertes intelligentes.
class IAConfig {
  /// ⏱️ Inactivité d’un animal (en jours)
  static const int inactiveDurationDays = 14;

  /// ⚠️ Pourcentage de variation de poids considéré comme anormal
  static const double weightAnomalyPercent = 20.0;

  /// 🧠 Active ou non les suggestions UX intelligentes
  static const bool enableSmartSuggestions = true;

  /// 🔔 Notifications auto en cas d'inactivité détectée
  static const bool autoNotifyOnInactivity = true;

  /// 🧹 Nombre maximum de logs IA avant nettoyage
  static const int maxLocalLogs = 50;
  static const int logsTrimTarget = 30;

  /// 🌐 Sync IA cloud activée (modifiable dans le futur via Remote Config)
  static const bool enableCloudSync = true;
}
