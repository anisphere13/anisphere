// TODO: ajouter test
import 'package:flutter/material.dart';
import '../models/genealogy_model.dart';

/// Section widget displaying breeder related information.
class IdentityBreederSection extends StatelessWidget {
  final GenealogyModel? genealogy;
  const IdentityBreederSection({super.key, this.genealogy});

  @override
  Widget build(BuildContext context) {
    if (genealogy == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Éleveur',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        if (genealogy!.affixe != null)
          _row('Affixe', genealogy!.affixe!),
        if (genealogy!.litterNumber != null)
          _row('Numéro de portée', genealogy!.litterNumber!),
        if (genealogy!.lofName != null)
          _row('Nom LOF', genealogy!.lofName!),
      ],
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
