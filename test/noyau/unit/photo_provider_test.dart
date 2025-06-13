import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('photo_provider placeholder', () {
    expect(true, isTrue);
  });
}
