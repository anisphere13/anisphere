// Copilot Prompt : Service Flutter pour accès et gestion des capteurs smartphone (GPS, mouvement, podomètre, batterie, réseau, orientation…)
// Expose des streams pour chaque type de donnée (distance, temps activité, changement position…)
// Récupère l’état batterie, la puissance réseau, l’heure système
library;

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Service Flutter pour l’accès aux capteurs du smartphone.
class DeviceSensorsService {
  final Battery _battery = Battery();
  final Connectivity _connectivity = Connectivity();

  /// Flux d’accéléromètre brut.
  Stream<AccelerometerEvent> get accelerometerStream =>
      accelerometerEventStream();

  /// Flux de gyroscope brut.
  Stream<GyroscopeEvent> get gyroscopeStream => gyroscopeEventStream();

  /// Flux du podomètre.
  Stream<StepCount> get pedometerStream => Pedometer.stepCountStream;

  /// Renvoie le niveau actuel de batterie en pourcentage.
  Future<int> getBatteryLevel() async {
    try {
      return await _battery.batteryLevel;
    } catch (e) {
      _log('Erreur récupération batterie : \\$e');
      return -1;
    }
  }

  /// Renvoie le type de connexion réseau (wifi/4g/offline).
  Future<ConnectivityResult> getConnectivity() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      _log('Erreur récupération connectivité : \\$e');
      return ConnectivityResult.none;
    }
  }

  /// Heure système actuelle.
  DateTime get currentTime => DateTime.now();

  void _log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }
}
  
