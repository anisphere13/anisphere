import '../ia_local/education_ia_predictor.dart';
import '../ia_local/ia_predictor.dart';

/// Registre simple des prédicteurs IA locaux par catégorie.
class IaLocalPredictors {
  static final Map<String, IaPredictor> _instances = {
    'education': EducationIaPredictor(),
  };

  static IaPredictor? of(String category) => _instances[category];
}
