library;

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

typedef HapticCallback = Future<void> Function();

class HapticFeedbackService {
  final HapticCallback _vibrateCallback;

  HapticFeedbackService({HapticCallback? vibrateCallback})
      : _vibrateCallback = vibrateCallback ?? HapticFeedback.lightImpact;

  Future<void> vibrate() async {
    try {
      await _vibrateCallback();
      _log('Haptic feedback triggered');
    } catch (e) {
      _log('Error triggering haptic feedback: $e');
    }
  }

  void _log(String msg) {
    if (kDebugMode) {
      debugPrint('[HapticFeedbackService] $msg');
    }
  }
}
