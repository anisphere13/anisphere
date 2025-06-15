library;

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

typedef SoundCallback = Future<void> Function(SystemSoundType type);

class FeedbackSoundService {
  final SoundCallback _playCallback;
  final SystemSoundType soundType;

  FeedbackSoundService({SoundCallback? playCallback, this.soundType = SystemSoundType.click})
      : _playCallback = playCallback ?? ((type) => SystemSound.play(type));

  Future<void> play() async {
    try {
      await _playCallback(soundType);
      _log('Sound played');
    } catch (e) {
      _log('Error playing sound: $e');
    }
  }

  void _log(String msg) {
    if (kDebugMode) {
      debugPrint('[FeedbackSoundService] $msg');
    }
  }
}
