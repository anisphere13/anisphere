// Copilot Prompt : Service qui enrichit en temps réel le contexte IA avec les données des capteurs (heure, batterie, réseau, habitudes…)
// Fournit un objet contextuel complet pour chaque décision IA
library;

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../logic/ia_context.dart';
import 'device_sensors_service.dart';

/// Enrichit l'IAContext avec les informations issues des capteurs.
class IAContextEnricher {
  final DeviceSensorsService sensors;

  IAContextEnricher({DeviceSensorsService? sensors})
      : sensors = sensors ?? DeviceSensorsService();

  /// Construit un IAContext enrichi à partir de la base existante.
  Future<IAContext> enrich(IAContext base) async {
    try {
      final connectivity = await sensors.getConnectivity();
      await sensors.getBatteryLevel(); // charge la valeur en cache si besoin

      return IAContext(
        isOffline: connectivity == ConnectivityResult.none,
        isFirstLaunch: base.isFirstLaunch,
        hasAnimals: base.hasAnimals,
        animalCount: base.animalCount,
        lastSyncDate: base.lastSyncDate,
      );
    } catch (e) {
      _log('Erreur enrichissement IAContext : \\$e');
      return base;
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }
}

