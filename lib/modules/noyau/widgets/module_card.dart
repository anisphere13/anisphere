library;

import 'package:flutter/material.dart';
import '../models/module_model.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel module;
  final String status;
  final VoidCallback? onTap;
  final VoidCallback? onActivate;

  const ModuleCard({
    super.key,
    required this.module,
    required this.status,
    this.onTap,
    this.onActivate,
  });

  Color _chipColor(BuildContext context) {
    switch (status) {
      case 'actif':
        return Theme.of(context).primaryColor;
      case 'premium':
        return const Color(0xFFFBC02D);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
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
                    backgroundColor: _chipColor(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                module.description,
                style: const TextStyle(color: Color(0xFF3A3A3A)),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: status == 'disponible' ? onActivate : onTap,
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
      ),
    );
  }
}
