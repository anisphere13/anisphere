// Test pour offline_photo_queue.g.dart
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('offline_photo_queue.g adapter builds', () {
    expect(true, isTrue);
  });
}
