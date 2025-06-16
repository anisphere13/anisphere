import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/iap_validator.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('iap_validator placeholder', () {
    final validator = IapValidator();
    expect(validator, isA<IapValidator>());
  });
}
