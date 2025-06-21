import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import '../models/module_model.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel module;
  final String status;
  final VoidCallback? onActivate;
<<<<<<< HEAD
=======
  final Widget? badge;
>>>>>>> codex/ajouter-paramètres-badge-et-ontap-à-modulecard
  final VoidCallback? onTap;

  const ModuleCard({
    super.key,
    required this.module,
    required this.status,
    this.onActivate,
<<<<<<< HEAD
=======
    this.badge,
>>>>>>> codex/ajouter-paramètres-badge-et-ontap-à-modulecard
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color chipColor = switch (status) {
      'actif' => const Color(0xFF183153),
      'disponible' => Colors.grey,
      'premium' => const Color(0xFFFBC02D),
      _ => Colors.grey,
    };

<<<<<<< HEAD
    final l10n = AppLocalizations.of(context)!;
    final title = module.id == 'identite'
        ? l10n.identityModuleTitle
        : module.name;
    final description = module.id == 'identite'
        ? l10n.identityModuleDescription
        : module.description;

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
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF183153),
=======
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
                            module.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF183153),
                            ),
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          badge!,
                        ],
                      ],
>>>>>>> codex/ajouter-paramètres-badge-et-ontap-à-modulecard
                    ),
                  ),
                  Chip(
                    label: Text(
                      status,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: chipColor,
                  ),
<<<<<<< HEAD
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
                  backgroundColor: const Color(0xFF183153),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: Text(status == 'disponible' ? 'Activer' : 'Découvrir'),
=======
                ],
>>>>>>> codex/ajouter-paramètres-badge-et-ontap-à-modulecard
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
      ),
    );
  }
}
