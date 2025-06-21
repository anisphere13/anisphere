import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';

<<<<<<< HEAD
/// Widget displaying the AI score for an animal identity.
class IdentityScoreWidget extends StatelessWidget {
  final double score; // 0-100
=======
/// Displays a progress bar for the identity completeness score.
class IdentityScoreWidget extends StatelessWidget {
  final double score;
>>>>>>> codex/créer-services-et-widgets-sous-lib/modules/identite
  const IdentityScoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
<<<<<<< HEAD
        Text(l10n.ai_score, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: score / 100),
        const SizedBox(height: 4),
        Text('${score.toStringAsFixed(0)}/100'),
=======
        Text(
          '${l10n.identity_summary_title} score: ${score.toStringAsFixed(0)}%',
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: score / 100),
>>>>>>> codex/créer-services-et-widgets-sous-lib/modules/identite
      ],
    );
  }
}
