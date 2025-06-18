import 'ia_result.dart';

abstract class IaPredictor {
  Future<void> loadModel() async {}
  Future<IaResult> predict(List<double> features);
  Future<void> dispose() async {}
}
