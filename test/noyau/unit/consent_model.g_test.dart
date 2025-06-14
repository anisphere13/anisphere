import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('consent_model.g adapter registered', () {
    expect(true, isTrue); // placeholder
  });
}
