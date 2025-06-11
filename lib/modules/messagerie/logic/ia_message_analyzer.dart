library;

/// Analyseur de messages simple pour déterminer l'intention utilisateur
/// et fournir un retour automatique.
class IAMessageAnalyzer {
  /// Retourne un couple {intent, feedback}
  Map<String, String> analyze(String message) {
    final lower = message.toLowerCase();
    String intent = 'other';
    String feedback = 'Message reçu.';

    if (lower.contains('bonjour') || lower.contains('salut')) {
      intent = 'greeting';
      feedback = 'Bonjour ! Comment puis-je vous aider ?';
    } else if (lower.contains('merci')) {
      intent = 'thanks';
      feedback = 'Avec plaisir !';
    } else if (lower.contains('bug') ||
        lower.contains('erreur') ||
        lower.contains('probl')) {
      intent = 'complaint';
      feedback = 'Nous sommes désolés du désagrément.';
    } else if (message.contains('?')) {
      intent = 'question';
      feedback = "Nous allons examiner votre question.";
    }

    return {'intent': intent, 'feedback': feedback};
  }
}
