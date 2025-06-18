// Copilot: Service d'analyse des commandes vocales pour AniSphère

/// Actions vocales possibles
enum VoiceAction { addReminder, showHealth, startWalk, unknown }

class VoiceCommand {
  final VoiceAction action;
  final Map<String, dynamic> metadata;

  VoiceCommand(this.action, [this.metadata = const {}]);
}

/// Analyse le texte reconnu et retourne l'action correspondante.
class VoiceCommandAnalyzer {
  VoiceCommand analyze(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('ajouter rappel')) {
      return VoiceCommand(VoiceAction.addReminder);
    } else if (lower.contains('santé')) {
      return VoiceCommand(VoiceAction.showHealth);
    } else if (lower.contains('promenade')) {
      return VoiceCommand(VoiceAction.startWalk);
    }
    return VoiceCommand(VoiceAction.unknown);
  }
}
