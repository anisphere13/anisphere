import 'package:tflite_flutter/tflite_flutter.dart';

import 'ia_model_loader.dart';
import 'ia_predictor.dart';
import 'ia_result.dart';

class EducationIaPredictor extends IaPredictor {
  Interpreter? _interpreter;

  @override
  Future<void> loadModel() async {
    if (_interpreter != null) return;
    try {
      final file = await IaModelLoader.loadModel('models/education.tflite');
      _interpreter = Interpreter.fromFile(file);
    } catch (_) {
      _interpreter = null;
    }
  }

  @override
  Future<IaResult> predict(List<double> features) async {
    await loadModel();
    try {
      final input = [features];
      final output = [
        <double>[0.0],
      ];
      _interpreter?.run(input, output);
      return IaResult(value: output.first.first, confidence: 1.0);
    } catch (_) {
      return const IaResult(value: null, confidence: 0.0);
    }
  }

  @override
  Future<void> dispose() async {
    _interpreter?.close();
    _interpreter = null;
  }
}
