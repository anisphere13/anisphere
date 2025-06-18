import 'package:flutter/material.dart';

import 'recommendation_result.dart';

/// Displays an AI recommendation in a friendly card.
class RecommendationWidget extends StatelessWidget {
  final RecommendationResult result;

  const RecommendationWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.method,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (result.idealDuration != null)
              Text('Durée idéale: ${result.idealDuration!.inMinutes} min'),
            Text('Difficulté: ${result.difficulty}'),
            Text(
                'Succès estimé: ${(result.successProbability * 100).toStringAsFixed(0)}%'),
            if (result.note != null) Text(result.note!),
          ],
        ),
      ),
    );
  }
}
