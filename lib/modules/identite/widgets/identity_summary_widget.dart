import 'package:flutter/material.dart';
import '../models/identity_model.dart';

/// Widget displaying main identity information.
class IdentitySummaryWidget extends StatelessWidget {
  final IdentityModel identity;
  const IdentitySummaryWidget({super.key, required this.identity});

  @override
  Widget build(BuildContext context) {
    const title = 'Identité';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (identity.microchipNumber != null)
              _row('Numéro de puce', identity.microchipNumber!),
            if (identity.status != null)
              _row('Statut', identity.status!),
            if (identity.legalStatus != null)
              _row('Statut juridique', identity.legalStatus!),
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
          Text('$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
