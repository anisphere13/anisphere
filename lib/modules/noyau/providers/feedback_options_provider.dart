// Copilot Prompt: "FeedbackOptionsProvider manages global audio and haptic settings across modules."
library;

import 'package:flutter/foundation.dart';
import '../services/local_storage_service.dart';
import '../services/modules_service.dart';

class FeedbackOptionsProvider with ChangeNotifier {
  static const _enabledKey = 'feedback_enabled';
  static const _volumeKey = 'feedback_volume';
  static const _intensityKey = 'feedback_intensity';

  bool _enabled = true;
  double _volume = 1.0;
  double _intensity = 1.0;
  final Map<String, bool> _moduleToggles = {};

  bool get enabled => _enabled;
  double get volume => _volume;
  double get intensity => _intensity;
  Map<String, bool> get moduleToggles => Map.unmodifiable(_moduleToggles);

  Future<void> load() async {
    _enabled = LocalStorageService.get(_enabledKey, defaultValue: true);
    _volume = LocalStorageService.get(_volumeKey, defaultValue: 1.0);
    _intensity = LocalStorageService.get(_intensityKey, defaultValue: 1.0);
    for (final module in ModulesService.allModules) {
      _moduleToggles[module] =
          LocalStorageService.get('feedback_module_$module', defaultValue: true);
    }
    notifyListeners();
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    await LocalStorageService.set(_enabledKey, value);
    notifyListeners();
  }

  Future<void> setVolume(double value) async {
    _volume = value;
    await LocalStorageService.set(_volumeKey, value);
    notifyListeners();
  }

  Future<void> setIntensity(double value) async {
    _intensity = value;
    await LocalStorageService.set(_intensityKey, value);
    notifyListeners();
  }

  Future<void> toggleModule(String module, bool value) async {
    _moduleToggles[module] = value;
    await LocalStorageService.set('feedback_module_$module', value);
    notifyListeners();
  }
}
