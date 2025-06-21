import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';

/// Displays a progress bar for the identity completeness score.
class IdentityScoreWidget extends StatelessWidget {
  final double score;
  const IdentityScoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.identity_summary_title} score: ${score.toStringAsFixed(0)}%',
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: score / 100),
      ],
    );
  }
}
