// Copilot Prompt : Écran des modules dans AniSphère.
// Affiche les modules disponibles avec cartes claires (nom, description, statut).
// Préparé pour activer, acheter ou découvrir chaque module.
// Inspiré de l’ergonomie Samsung Health.
library;
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';
import 'package:anisphere/theme.dart';
import 'modules_by_category_screen.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({super.key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  final ModulesService _modulesService = ModulesService();

  final List<ModuleModel> _modules = ModulesService.modules;

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
        children: _buildSections(),
      ),
    );
  }

  List<Widget> _buildSections() {
    final Map<String, List<ModuleModel>> byCategory = {};
    for (final m in _modules) {
      byCategory.putIfAbsent(m.category, () => []).add(m);
    }
    return byCategory.entries
        .map((e) => _buildModuleCategorySection(e.key, e.value))
        .toList();
  }

  Widget _buildModuleCategorySection(String category, List<ModuleModel> modules) {
    final display = modules.length > 5 ? modules.sublist(0, 5) : modules;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: display.length,
            itemBuilder: (context, index) {
              final module = display[index];
              final status = _statuses[module.id] ?? 'disponible';
              return SizedBox(
                width: 250,
                child: _buildModuleCard(module, status),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ModulesByCategoryScreen(category: category),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: primaryBlue),
            child: const Text('Voir plus'),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildModuleCard(ModuleModel module, String status) {
    final Color chipColor = switch (status) {
      'actif' => primaryBlue,
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
                      color: primaryBlue,
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
              style: const TextStyle(color: Color(0xFF3A3A3A)),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: (status == 'disponible')
                    ? () => _activate(module.id)
                    : null,
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
    );
  }
}
