// Analyse Vidéo AniSphère

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../ia_local/ia_model_loader.dart';

/// Prédicteur vidéo simple basé sur TFLite.
class IAVideoPredictor {
  Interpreter? _interpreter;

  Future<void> _init() async {
    if (_interpreter != null) return;
    try {
      final file = await IaModelLoader.loadModel('models/video.tflite');
      _interpreter = Interpreter.fromFile(file);
    } catch (e) {
      _log('Erreur init modèle vidéo : $e');
    }
  }

  Future<double> predict(List<double> features) async {
    await _init();
    try {
      final input = [features];
      final output = [<double>[0.0]];
      _interpreter?.run(input, output);
      return output.first.first;
    } catch (e) {
      _log('Erreur prédiction vidéo : $e');
      return 0.0;
    }
  }

  Future<void> dispose() async {
    _interpreter?.close();
    _interpreter = null;
  }

  void _log(String msg) {
    if (kDebugMode) debugPrint(msg);
  }
}
