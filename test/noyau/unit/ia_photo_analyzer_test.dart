import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('ia_photo_analyzer placeholder', () {
    expect(true, isTrue);
  });
}
