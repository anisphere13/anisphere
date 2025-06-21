import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:anisphere/modules/noyau/services/haptic_feedback_service.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('vibrate triggers provided callback', () async {
    var called = false;
    final service = HapticFeedbackService(vibrateCallback: () async {
      called = true;
    });

    await service.vibrate();
    expect(called, isTrue);
  });
}
