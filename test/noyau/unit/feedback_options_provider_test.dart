import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/providers/feedback_options_provider.dart';
import 'package:anisphere/modules/noyau/services/feedback_sound_service.dart';
import 'package:anisphere/modules/noyau/services/haptic_feedback_service.dart';
import '../../test_config.dart';

class FakeSoundService extends FeedbackSoundService {
  bool played = false;
  FakeSoundService() : super(playCallback: (_) async {});

  @override
  Future<void> play() async {
    played = true;
  }
}

class FakeHapticService extends HapticFeedbackService {
  bool vibrated = false;
  FakeHapticService() : super(vibrateCallback: () async {});

  @override
  Future<void> vibrate() async {
    vibrated = true;
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('triggerFeedback respects preferences', () async {
    final sound = FakeSoundService();
    final haptic = FakeHapticService();
    final provider = FeedbackOptionsProvider(
      soundService: sound,
      hapticService: haptic,
    );

    await provider.triggerFeedback();
    expect(sound.played, isTrue);
    expect(haptic.vibrated, isTrue);

    sound.played = false;
    haptic.vibrated = false;

    provider.setSoundEnabled(false);
    provider.setHapticEnabled(false);
    await provider.triggerFeedback();
    expect(sound.played, isFalse);
    expect(haptic.vibrated, isFalse);
  });
}
