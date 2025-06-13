// Copilot Prompt : Service qui ajuste les priorités IA (analyses, notifications, sync) selon l’état réseau/batterie, l’heure et les habitudes
// Peut désactiver ou retarder analyses si batterie faible/réseau mauvais
library;

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'device_sensors_service.dart';

/// Service d’adaptation IA selon le contexte réel.
class IAAdaptationService {
  final DeviceSensorsService sensors;

  IAAdaptationService({DeviceSensorsService? sensors})
      : sensors = sensors ?? DeviceSensorsService();

  /// Exemple de décision simplifiée.
  Future<bool> shouldRunHeavyAnalysis() async {
    final battery = await sensors.getBatteryLevel();
    final connectivity = await sensors.getConnectivity();
    final isLowBattery = battery >= 0 && battery < 20;
    final isOffline = connectivity == ConnectivityResult.none;

    return !isLowBattery && !isOffline;
  }

  void log(String msg) {
    if (kDebugMode) {
      debugPrint(msg);
    }
  }
}

