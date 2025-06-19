import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import '../models/genealogy_model.dart';

/// Card displaying a short summary of genealogy information.
class GenealogySummaryCard extends StatelessWidget {
  final GenealogyModel genealogy;
  const GenealogySummaryCard({super.key, required this.genealogy});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.genealogy_title,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _row(l10n.father, genealogy.fatherName ?? '-'),
            _row(l10n.mother, genealogy.motherName ?? '-'),
            if (genealogy.affixe != null)
              _row(l10n.breeder_affixe, genealogy.affixe!),
            if (genealogy.litterNumber != null)
              _row(l10n.litter_number, genealogy.litterNumber!),
            if (genealogy.lofName != null)
              _row(l10n.lof_name, genealogy.lofName!),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
