import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:anisphere/modules/noyau/services/feedback_sound_service.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('play triggers provided callback', () async {
    var called = false;
    final service = FeedbackSoundService(playCallback: (type) async {
      expect(type, SystemSoundType.click);
      called = true;
    });

    await service.play();
    expect(called, isTrue);
  });
}
