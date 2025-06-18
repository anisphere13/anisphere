// Copilot Prompt : Modèle IA calculant score engagement/progression à partir des données capteurs + historique utilisateur/animal
// Intègre les critères IA, pondère selon contexte, module, performance attendue

/// Représente un score d’engagement calculé pour un utilisateur ou un animal.
class EngagementScore {
  final String id;
  final double score;
  final DateTime date;

  const EngagementScore({required this.id, required this.score, required this.date});
}

