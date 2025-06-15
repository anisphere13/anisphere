// Copilot Prompt : Écran des modules dans AniSphère.
// Affiche les modules disponibles avec cartes claires (nom, description, statut).
// Préparé pour activer, acheter ou découvrir chaque module.
// Inspiré de l’ergonomie Samsung Health.
library;
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({super.key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  final ModulesService _modulesService = ModulesService();

  final Map<String, List<Map<String, String>>> _modulesByCategory = {
    'Bien-être': [
      {
        "id": "sante",
        "name": "Santé",
        "description": "Suivi des vaccins, visites, soins médicaux.",
      },
      {
        "id": "dressage",
        "name": "Dressage",
        "description": "Entraînement avancé, objectifs, IA comparative.",
      },
    ],
    'Apprentissage': [
      {
        "id": "education",
        "name": "Éducation",
        "description": "Programmes éducatifs IA et routines personnalisées.",
      },
    ],
  };

  Map<String, String> _statuses = {};

  @override
  void initState() {
    super.initState();
    _loadStatuses();
  }

  Future<void> _loadStatuses() async {
    final status = await _modulesService.getAllStatuses();
    setState(() {
      _statuses = status;
    });
  }

  Future<void> _activate(String id) async {
    await _modulesService.setActive(id);
    _loadStatuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _modulesByCategory.entries.map((entry) {
          final modules = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: modules.length,
                  itemBuilder: (context, idx) {
                    final module = modules[idx];
                    final id = module['id']!;
                    final status = _statuses[id] ?? 'disponible';
                    return SizedBox(
                      width: 220,
                      child: _buildModuleCard(module, status),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModuleCard(Map<String, String> module, String status) {
    final Color chipColor = switch (status) {
      "actif" => const Color(0xFF183153),
      "disponible" => Colors.grey,
      "premium" => const Color(0xFFFBC02D),
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
                    status,
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
                onPressed: (status == "disponible")
                    ? () => _activate(module["id"]!)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF183153),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: Text(status == "disponible" ? "Activer" : "Découvrir"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
