import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/ia_local/education_ia_predictor.dart';
import '../../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('predict returns result without throwing', () async {
    final predictor = EducationIaPredictor();
    final result = await predictor.predict([0.0]);
    expect(result, isNotNull);
  });
}
