// Copilot Prompt : HapticFeedbackService pour AniSphère.
// Fournit des vibrations prédéfinies (léger, moyen, fort, sélection).
// Permet aussi de passer un motif personnalisé pour un retour précis.
library;
// TODO: ajouter test

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// Type de vibration utilisable par [HapticFeedbackService].
class FeedbackHapticType {
  final String name;
  final List<int>? pattern;

  const FeedbackHapticType._(this.name, [this.pattern]);

  static const light = FeedbackHapticType._('light');
  static const medium = FeedbackHapticType._('medium');
  static const heavy = FeedbackHapticType._('heavy');
  static const selection = FeedbackHapticType._('selection');

  const FeedbackHapticType.custom(List<int> pattern)
      : name = 'custom',
        pattern = pattern;
}

/// Service gérant les retours haptiques.
class HapticFeedbackService {
  /// Déclenche la vibration associée au [type].
  static Future<void> vibrate(FeedbackHapticType type) async {
    try {
      switch (type.name) {
        case 'light':
          await HapticFeedback.lightImpact();
          break;
        case 'medium':
          await HapticFeedback.mediumImpact();
          break;
        case 'heavy':
          await HapticFeedback.heavyImpact();
          break;
        case 'selection':
          await HapticFeedback.selectionClick();
          break;
        default:
          if (type.pattern != null && (await Vibration.hasVibrator() ?? false)) {
            await Vibration.vibrate(pattern: type.pattern);
          } else {
            await HapticFeedback.vibrate();
          }
      }
    } catch (e) {
      debugPrint('Erreur vibration : $e');
    }
  }
}
