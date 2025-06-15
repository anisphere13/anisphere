library;

import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final String name;
  final String? description;
  final VoidCallback? onTap;

  const ModuleCard({
    super.key,
    required this.name,
    this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: description != null ? Text(description!) : null,
        onTap: onTap,
      ),
    );
  }
}
