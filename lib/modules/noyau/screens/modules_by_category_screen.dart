library;

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';
import 'package:anisphere/modules/noyau/widgets/module_card.dart';

class ModulesByCategoryScreen extends StatefulWidget {
  const ModulesByCategoryScreen({super.key});

  @override
  State<ModulesByCategoryScreen> createState() => _ModulesByCategoryScreenState();
}

class _ModulesByCategoryScreenState extends State<ModulesByCategoryScreen> {
  final ModulesService _modulesService = ModulesService();

  final Map<String, List<ModuleModel>> _modulesByCategory = const {
    'Bien-être': [
      ModuleModel(
        id: 'sante',
        name: 'Santé',
        description: 'Suivi des vaccins, visites, soins médicaux.',
      ),
    ],
    'Apprentissage': [
      ModuleModel(
        id: 'education',
        name: 'Éducation',
        description: 'Programmes éducatifs IA et routines personnalisées.',
      ),
      ModuleModel(
        id: 'dressage',
        name: 'Dressage',
        description: 'Entraînement avancé, objectifs, IA comparative.',
      ),
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
    setState(() => _statuses = status);
  }

  Future<void> _activate(String id) async {
    await _modulesService.setActive(id);
    _loadStatuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modules par catégorie')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _modulesByCategory.entries
            .expand((entry) => [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      entry.key,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ...entry.value.map((m) {
                    final status = _statuses[m.id] ?? 'disponible';
                    return ModuleCard(
                      module: m,
                      status: status,
                      onActivate: () => _activate(m.id),
                    );
                  }),
                ])
            .toList(),
      ),
    );
  }
}
