import 'package:flutter/material.dart';
import '../models/module_model.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel module;
  final String status;
  final VoidCallback? onActivate;

  const ModuleCard({
    super.key,
    required this.module,
    required this.status,
    this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    final Color chipColor = switch (status) {
      'actif' => const Color(0xFF183153),
      'disponible' => Colors.grey,
      'premium' => const Color(0xFFFBC02D),
      _ => Colors.grey,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    module.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF183153),
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: chipColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              module.description,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: (status == 'disponible') ? onActivate : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF183153),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: Text(status == 'disponible' ? 'Activer' : 'Découvrir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
