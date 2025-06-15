library;

import 'package:flutter/foundation.dart';

import '../services/feedback_sound_service.dart';
import '../services/haptic_feedback_service.dart';
import '../services/local_storage_service.dart';

class FeedbackOptionsProvider with ChangeNotifier {
  bool soundEnabled;
  bool hapticEnabled;
  double _volume = 1.0;
  double _intensity = 1.0;
  Map<String, bool> _moduleToggles = {};
  final FeedbackSoundService soundService;
  final HapticFeedbackService hapticService;

  FeedbackOptionsProvider({
    FeedbackSoundService? soundService,
    HapticFeedbackService? hapticService,
    this.soundEnabled = true,
    this.hapticEnabled = true,
  })  : soundService = soundService ?? FeedbackSoundService(),
        hapticService = hapticService ?? HapticFeedbackService();

  /// Charge les préférences depuis le stockage local.
  Future<void> load() async {
    soundEnabled = await LocalStorageService.getBool('feedback_sound_enabled', defaultValue: true);
    hapticEnabled = await LocalStorageService.getBool('feedback_haptic_enabled', defaultValue: true);
    _volume = (LocalStorageService.get('feedback_volume', defaultValue: 1.0) as num).toDouble();
    _intensity = (LocalStorageService.get('feedback_intensity', defaultValue: 1.0) as num).toDouble();
    final toggles = LocalStorageService.get('feedback_module_toggles', defaultValue: <String, bool>{});
    if (toggles is Map) {
      _moduleToggles = Map<String, bool>.from(toggles);
    }
    notifyListeners();
  }

  double get volume => _volume;
  double get intensity => _intensity;
  Map<String, bool> get moduleToggles => _moduleToggles;
  bool get enabled => soundEnabled && hapticEnabled;

  void setSoundEnabled(bool value) {
    soundEnabled = value;
    notifyListeners();
  }

  void setHapticEnabled(bool value) {
    hapticEnabled = value;
    notifyListeners();
  }

  Future<void> setEnabled(bool value) async {
    soundEnabled = value;
    hapticEnabled = value;
    await LocalStorageService.set('feedback_sound_enabled', value);
    await LocalStorageService.set('feedback_haptic_enabled', value);
    notifyListeners();
  }

  Future<void> setVolume(double value) async {
    _volume = value;
    await LocalStorageService.set('feedback_volume', value);
    notifyListeners();
  }

  Future<void> setIntensity(double value) async {
    _intensity = value;
    await LocalStorageService.set('feedback_intensity', value);
    notifyListeners();
  }

  Future<void> toggleModule(String module, bool value) async {
    _moduleToggles[module] = value;
    await LocalStorageService.set('feedback_module_toggles', _moduleToggles);
    notifyListeners();
  }

  Future<void> triggerFeedback({String? module}) async {
    if (!enabled) return;
    if (module != null && _moduleToggles[module] == false) return;
    if (soundEnabled) {
      await soundService.play();
    }
    if (hapticEnabled) {
      await hapticService.vibrate();
    }
  }
}
