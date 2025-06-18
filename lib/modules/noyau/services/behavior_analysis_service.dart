// Copilot Prompt : Service IA local basé sur TFLite, analyse les données capteurs et images pour mesurer comportement animal/utilisateur (distance, répétition, posture, etc.)
// Intègre les modèles TFLite pour détection posture, pathologie visible, type activité, etc.
// Agrège distance parcourue, temps, fréquence, localisation pour chaque session

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'device_sensors_service.dart';

/// Analyse comportementale IA locale.
class BehaviorAnalysisService {
  final DeviceSensorsService sensors;
  Interpreter? _interpreter;

  BehaviorAnalysisService({DeviceSensorsService? sensors})
      : sensors = sensors ?? DeviceSensorsService();

  /// Initialise les modèles TFLite.
  Future<void> init() async {
    try {
      _interpreter ??= await Interpreter.fromAsset('models/behavior.tflite');
    } catch (e) {
      _log('Erreur init TFLite : \\$e');
    }
  }

  /// Exemple d’analyse basique.
  Future<double> analyzeSteps() async {
    await init();
    try {
      final event =
          await sensors.pedometerStream.first.timeout(const Duration(seconds: 1));
      final input = [
        [event.steps.toDouble()]
      ];
      final output = [
        [0.0]
      ];
      if (_interpreter != null) {
        _interpreter!.run(input, output);
        return output.first.first;
      }
      return input.first.first;
    } catch (e) {
      _log('Erreur analyseSteps : $e');
      return 0.0;
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }
}

