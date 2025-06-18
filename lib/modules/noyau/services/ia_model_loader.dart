import 'package:tflite_flutter/tflite_flutter.dart';

/// Utility class to load and run local TensorFlow Lite models.
class IaModelLoader {
  final String modelPath;
  final Future<Interpreter> Function(String path) _creator;
  Interpreter? _interpreter;

  IaModelLoader({required this.modelPath, Future<Interpreter> Function(String path)? creator})
      : _creator = creator ?? Interpreter.fromAsset;

  /// Loaded interpreter instance.
  Interpreter? get interpreter => _interpreter;

  /// Loads the model from [modelPath].
  /// Returns `true` if the model was loaded successfully.
  Future<bool> load() async {
    try {
      _interpreter = await _creator(modelPath);
      return true;
    } catch (_) {
      _interpreter = null;
      return false;
    }
  }

  /// Runs a prediction on [input] and returns the raw output list.
  /// Throws a [StateError] if the model is not loaded.
  Future<List<double>> predict(List<double> input, {int outputLength = 1}) async {
    final interp = _interpreter;
    if (interp == null) {
      throw StateError('Model not loaded');
    }
    final output = List<double>.filled(outputLength, 0);
    interp.run([input], [output]);
    return output;
  }
}
