import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import '../models/genealogy_model.dart';
import '../widgets/genealogy_summary_card.dart';

/// Screen displaying a simple genealogy tree for an animal.
class GenealogyScreen extends StatelessWidget {
  final GenealogyModel genealogy;
  const GenealogyScreen({super.key, required this.genealogy});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.genealogy_title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _parentCard(l10n.father, genealogy.fatherId ?? '-'),
                const SizedBox(width: 20),
                _parentCard(l10n.mother, genealogy.motherId ?? '-'),
              ],
            ),
            const Icon(Icons.arrow_downward, size: 32),
            GenealogySummaryCard(genealogy: genealogy),
          ],
        ),
      ),
    );
  }

  Widget _parentCard(String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value),
          ],
        ),
      ),
    );
  }
}
