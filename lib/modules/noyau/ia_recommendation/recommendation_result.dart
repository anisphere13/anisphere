/// Result object for AI recommendations.
/// Contains all data needed to display suggestions in the UI.
class RecommendationResult {
  final String method;
  final Duration? idealDuration;
  final String difficulty;
  final double successProbability;
  final String? note;

  const RecommendationResult({
    required this.method,
    this.idealDuration,
    this.difficulty = 'medium',
    this.successProbability = 0.5,
    this.note,
  });
}
