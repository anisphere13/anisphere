// Copilot Prompt: Helper fournissant le contexte des tâches planifiées.
// Récupère le niveau de batterie, létat de la connectivité et détermine les périodes d'inactivité ou de nuit.
library;

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Utilitaires pour déterminer quand exécuter des jobs en arrière-plan.
class JobContextHelper {
  /// Objets modifiables pour les tests unitaires.
  static Battery battery = Battery();
  static Connectivity connectivity = Connectivity();

  /// Renvoie le niveau de batterie actuel ou -1 en cas d'erreur.
  static Future<int> batteryLevel() async {
    try {
      return await battery.batteryLevel;
    } catch (_) {
      return -1;
    }
  }

  /// Renvoie l'état de la connectivité actuelle.
  static Future<List<ConnectivityResult>> connectivityState() async {
    try {
      return await connectivity.checkConnectivity();
    } catch (_) {
      return [ConnectivityResult.none];
    }
  }

  /// Indique si l'heure fournie (ou actuelle) correspond à une période d'inactivité (22h-6h).
  static bool isIdleNightTime([DateTime? now]) {
    final hour = (now ?? DateTime.now()).hour;
    return hour >= 22 || hour < 6;
  }
}
