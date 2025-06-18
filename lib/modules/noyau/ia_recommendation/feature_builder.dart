import '../models/animal_model.dart';

/// Builds numerical/text features for the recommendation models
/// from the animal profile and user history.
class FeatureBuilder {
  /// Simple example using age, breed and last score.
  static Map<String, dynamic> build({
    required AnimalModel animal,
    Map<String, dynamic>? history,
  }) {
    final age = animal.birthDate != null
        ? DateTime.now().difference(animal.birthDate!).inDays / 365.0
        : 0.0;
    final features = <String, dynamic>{
      'age': age,
      'species': animal.species,
      'breed': animal.breed,
    };
    if (history != null) {
      features.addAll(history);
    }
    return features;
  }
}
