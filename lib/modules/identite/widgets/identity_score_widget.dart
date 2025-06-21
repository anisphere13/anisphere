import 'package:flutter/material.dart';

/// Widget displaying the AI score for an animal identity.
class IdentityScoreWidget extends StatelessWidget {
  /// Score from 0 to 100.
  final double score;

  const IdentityScoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Score IA', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: score / 100),
        const SizedBox(height: 4),
        Text('${score.toStringAsFixed(0)}/100'),
      ],
    );
  }
}
