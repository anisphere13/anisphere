import 'package:tflite_flutter/tflite_flutter.dart';

import 'feature_builder.dart';
import '../models/animal_model.dart';
import 'recommendation_result.dart';

/// Local TFLite engine used for free accounts or offline mode.
class IaLocalEngine {
  Interpreter? _interpreter;

  Future<void> _init() async {
    _interpreter ??= await Interpreter.fromAsset('models/recommendation.tflite');
  }

  Future<RecommendationResult> recommend({
    required AnimalModel animal,
    Map<String, dynamic>? history,
  }) async {
    await _init();
    final features = FeatureBuilder.build(animal: animal, history: history);
    final input = [features.values.map((e) => e is num ? e : 0).toList()];
    final output = List.filled(4, 0.0).reshape([1, 4]);
    if (_interpreter != null) {
      _interpreter!.run(input, output);
      return RecommendationResult(
        method: 'model',
        idealDuration: Duration(minutes: (output[0][0] * 60).round()),
        difficulty: _mapDifficulty(output[0][1]),
        successProbability: output[0][2].toDouble(),
        note: null,
      );
    }
    // basic fallback
    return const RecommendationResult(method: 'basic');
  }

  String _mapDifficulty(double value) {
    if (value > 0.66) return 'hard';
    if (value > 0.33) return 'medium';
    return 'easy';
  }
}
