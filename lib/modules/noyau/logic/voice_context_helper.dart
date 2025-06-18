// Copilot: Helper pour déterminer le contexte vocal (promenade, dressage, santé)

/// Contextes possibles pour un message vocal
enum VoiceContext { promenade, dressage, sante, inconnu }

class VoiceContextHelper {
  /// Détermine le contexte d'après le texte et renvoie le contexte et métadonnées.
  Map<String, dynamic> detectContext(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('promenade')) {
      return {'context': VoiceContext.promenade};
    } else if (lower.contains('dressage')) {
      return {'context': VoiceContext.dressage};
    } else if (lower.contains('santé')) {
      return {'context': VoiceContext.sante};
    }
    return {'context': VoiceContext.inconnu};
  }
}
