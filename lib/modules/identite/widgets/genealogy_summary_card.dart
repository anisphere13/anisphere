import 'package:flutter/material.dart';
import '../models/genealogy_model.dart';

/// Card displaying a short summary of genealogy information.
class GenealogySummaryCard extends StatelessWidget {
  final GenealogyModel genealogy;
  const GenealogySummaryCard({super.key, required this.genealogy});

  @override
  Widget build(BuildContext context) {
    const title = 'Généalogie';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _row('Père', genealogy.fatherName ?? '-'),
            _row('Mère', genealogy.motherName ?? '-'),
            if (genealogy.affixe != null)
              _row('Affixe', genealogy.affixe!),
            if (genealogy.litterNumber != null)
              _row('Numéro de portée', genealogy.litterNumber!),
            if (genealogy.lofName != null)
              _row('Nom LOF', genealogy.lofName!),
            if (genealogy.originCountry != null)
              _row('Origin', genealogy.originCountry!),
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
