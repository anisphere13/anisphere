import 'package:flutter/material.dart';

class GenealogySummaryCard extends StatelessWidget {
  final String animalId;
  final String? fatherId;
  final String? motherId;
  const GenealogySummaryCard({
    super.key,
    required this.animalId,
    this.fatherId,
    this.motherId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Genealogy of $animalId'),
        subtitle: Text('Father: ${fatherId ?? '-'}, Mother: ${motherId ?? '-'}'),
      ),
    );
  }
}
