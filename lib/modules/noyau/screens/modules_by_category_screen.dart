library;

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/widgets/module_card.dart';

class ModulesByCategoryScreen extends StatefulWidget {
  const ModulesByCategoryScreen({super.key});

  @override
  State<ModulesByCategoryScreen> createState() => _ModulesByCategoryScreenState();
}

class _ModulesByCategoryScreenState extends State<ModulesByCategoryScreen> {
  final ModulesService _modulesService = ModulesService();

  final Map<String, List<ModuleModel>> _modules = {
    'Général': const [
      ModuleModel(
        id: 'sante',
        name: 'Santé',
        description: 'Suivi des vaccins, visites, soins médicaux.',
      ),
      ModuleModel(
        id: 'education',
        name: 'Éducation',
        description: 'Programmes éducatifs IA et routines personnalisées.',
      ),
    ],
    'Compétences': const [
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
        children: _modules.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183153),
                ),
              ),
              const SizedBox(height: 8),
              ...entry.value.map((m) {
                final status = _statuses[m.id] ?? 'disponible';
                return ModuleCard(
                  module: m,
                  status: status,
                  onActivate: () => _activate(m.id),
                );
              }),
              const SizedBox(height: 24),
            ],
          );
        }).toList(),
      ),
    );
  }
}
