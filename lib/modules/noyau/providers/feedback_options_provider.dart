library;

import 'package:flutter/foundation.dart';

import '../services/feedback_sound_service.dart';
import '../services/haptic_feedback_service.dart';

class FeedbackOptionsProvider with ChangeNotifier {
  bool soundEnabled;
  bool hapticEnabled;
  final FeedbackSoundService soundService;
  final HapticFeedbackService hapticService;

  FeedbackOptionsProvider({
    FeedbackSoundService? soundService,
    HapticFeedbackService? hapticService,
    this.soundEnabled = true,
    this.hapticEnabled = true,
  })  : soundService = soundService ?? FeedbackSoundService(),
        hapticService = hapticService ?? HapticFeedbackService();

  void setSoundEnabled(bool value) {
    soundEnabled = value;
    notifyListeners();
  }

  void setHapticEnabled(bool value) {
    hapticEnabled = value;
    notifyListeners();
  }

  Future<void> triggerFeedback() async {
    if (soundEnabled) {
      await soundService.play();
    }
    if (hapticEnabled) {
      await hapticService.vibrate();
    }
  }
}
