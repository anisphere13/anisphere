// Copilot Prompt : Service IA local TFLite dédié à l’analyse d’image/photo prise par l’utilisateur : posture, anomalie, maladie visible, type d’activité
library;

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

/// Analyse d’image locale via TFLite.
class ImageAnalysisService {
  Interpreter? _interpreter;

  /// Initialise le modèle.
  Future<void> init() async {
    try {
      _interpreter ??= await Interpreter.fromAsset('models/image.tflite');
    } catch (e) {
      _log('Erreur init modèle image : \\$e');
    }
  }

  /// Analyse une image et renvoie un label.
  Future<String> analyze(List<double> input) async {
    await init();
    // TODO: appel réel au modèle
    return 'unknown';
  }

  void _log(String msg) {
    if (kDebugMode) {
      debugPrint(msg);
    }
  }
}

