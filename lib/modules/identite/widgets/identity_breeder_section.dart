import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import '../models/genealogy_model.dart';

/// Section widget displaying breeder related information.
class IdentityBreederSection extends StatelessWidget {
  final GenealogyModel? genealogy;
  const IdentityBreederSection({super.key, this.genealogy});

  @override
  Widget build(BuildContext context) {
    if (genealogy == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.breeder_section_title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        if (genealogy!.affixe != null)
          _row(l10n.breeder_affixe, genealogy!.affixe!),
        if (genealogy!.litterNumber != null)
          _row(l10n.litter_number, genealogy!.litterNumber!),
        if (genealogy!.lofName != null)
          _row(l10n.lof_name, genealogy!.lofName!),
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
