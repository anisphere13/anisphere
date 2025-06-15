// Copilot Prompt : FeedbackSoundService pour AniSphère.
// Joue des sons de retour utilisateur (succès, erreur, alerte, validation).
// Les modules peuvent enregistrer ou remplacer leurs propres sons dynamiquement.
library;
// TODO: ajouter test

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Type de son jouable par [FeedbackSoundService].
class FeedbackSoundType {
  final String name;
  const FeedbackSoundType(this.name);

  static const success = FeedbackSoundType('success');
  static const error = FeedbackSoundType('error');
  static const alert = FeedbackSoundType('alert');
  static const validation = FeedbackSoundType('validation');

  @override
  bool operator ==(Object other) =>
      other is FeedbackSoundType && other.name == name;

  @override
  int get hashCode => name.hashCode;
}

/// Service qui gère la lecture de sons de feedback.
class FeedbackSoundService {
  final AudioPlayer _player;
  final Map<FeedbackSoundType, String> _sounds = {
    FeedbackSoundType.success: 'assets/sounds/success.mp3',
    FeedbackSoundType.error: 'assets/sounds/error.mp3',
    FeedbackSoundType.alert: 'assets/sounds/alert.mp3',
    FeedbackSoundType.validation: 'assets/sounds/validation.mp3',
  };

  FeedbackSoundService({AudioPlayer? player}) : _player = player ?? AudioPlayer();

  /// Enregistre ou remplace un son pour [type].
  void registerSound(FeedbackSoundType type, String assetPath) {
    _sounds[type] = assetPath;
  }

  /// Joue le son associé au [type] s'il existe.
  Future<void> play(FeedbackSoundType type) async {
    final path = _sounds[type];
    if (path == null) return;
    try {
      await _player.play(AssetSource(path));
    } catch (e) {
      debugPrint('Erreur lecture son : $e');
    }
  }
}
