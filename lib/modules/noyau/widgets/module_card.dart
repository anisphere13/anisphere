import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../models/module_model.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel module;
  final String status;
  final VoidCallback? onActivate;
  final Widget? badge;
  final VoidCallback? onTap;

  const ModuleCard({
    super.key,
    required this.module,
    required this.status,
    this.onActivate,
    this.badge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color chipColor = switch (status) {
      'actif' => const primaryBlue,
      'disponible' => Colors.grey,
      'premium' => primaryBlue,
      _ => Colors.grey,
    };

    final title = module.id == 'identite'
        ? 'Identité'
        : module.name;
    final description = module.id == 'identite'
        ? "Gérer l'identité de l'animal"
        : module.description;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          badge!,
                        ],
                      ],
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
                description,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: (status == 'disponible') ? onActivate : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
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
