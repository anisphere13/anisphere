import 'package:flutter/material.dart';

class GenealogySummaryCard extends StatelessWidget {
  final String animalId;
  final String? fatherName;
  final String? motherName;
  const GenealogySummaryCard({
    super.key,
    required this.animalId,
    this.fatherName,
    this.motherName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Genealogy of $animalId'),
        subtitle:
            Text('Father: ${fatherName ?? '-'}, Mother: ${motherName ?? '-'}'),
      ),
    );
  }
}
