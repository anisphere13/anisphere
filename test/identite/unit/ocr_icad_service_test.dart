import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('RegExp extracts microchip number', () {
    const sample = 'Numéro de puce : 250269604785123';
    final match = RegExp(r'(\d{15})').firstMatch(sample);
    expect(match?.group(1), equals('250269604785123'));
  });
}
