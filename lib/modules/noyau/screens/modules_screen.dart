/// Copilot Prompt : Écran des modules dans AniSphère.
/// Affiche les modules disponibles avec cartes claires (nom, description, statut).
/// Préparé pour activer, acheter ou découvrir chaque module.
/// Inspiré de l’ergonomie Samsung Health.
import 'package:flutter/material.dart';

class ModulesScreen extends StatelessWidget {
  const ModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modules = [
      {
        "name": "Santé",
        "description": "Suivi des vaccins, visites, soins médicaux.",
        "status": "actif",
      },
      {
        "name": "Éducation",
        "description": "Programmes éducatifs IA et routines personnalisées.",
        "status": "disponible",
      },
      {
        "name": "Dressage",
        "description": "Entraînement avancé, objectifs, IA comparative.",
        "status": "premium",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Modules")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          return _buildModuleCard(module);
        },
      ),
    );
  }

  Widget _buildModuleCard(Map<String, String> module) {
    final status = module["status"];
    final Color cardColor = Colors.white;
    final Color chipColor = switch (status) {
      "actif" => const Color(0xFF183153),
      "disponible" => Colors.grey,
      "premium" => const Color(0xFFFBC02D),
      _ => Colors.grey,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: cardColor,
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
                    module["name"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF183153),
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    status!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: chipColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              module["description"]!,
              style: const TextStyle(color: Color(0xFF3A3A3A)),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // à implémenter : activer / acheter / tester
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF183153),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Découvrir"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

