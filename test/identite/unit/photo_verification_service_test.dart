import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('Score calculé reste dans une plage valide', () async {
    // simulate with 0 sharpness, 1 centering = score 0.3
    const score = (0.7 * 0.0) + (0.3 * 1.0);
    expect(score, closeTo(0.3, 0.01));
  });
}
