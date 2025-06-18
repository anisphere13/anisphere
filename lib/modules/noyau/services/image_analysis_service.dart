// Copilot Prompt : Service IA local TFLite dédié à l’analyse d’image/photo prise par l’utilisateur : posture, anomalie, maladie visible, type d’activité

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../ia_local/ia_model_loader.dart';

/// Analyse d’image locale via TFLite.
class ImageAnalysisService {
  Interpreter? _interpreter;

  /// Initialise le modèle.
  Future<void> init() async {
    try {
      if (_interpreter != null) return;
      final file = await IaModelLoader.loadModel('models/image.tflite');
      _interpreter = await Interpreter.fromFile(file);
    } catch (e) {
      _log('Erreur init modèle image : $e');
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
