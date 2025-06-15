// Copilot Prompt : Écran des modules dans AniSphère.
// Affiche les modules disponibles avec cartes claires (nom, description, statut).
// Préparé pour activer, acheter ou découvrir chaque module.
// Inspiré de l’ergonomie Samsung Health.
library;
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';
import 'package:anisphere/modules/noyau/widgets/module_card.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({super.key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  final ModulesService _modulesService = ModulesService();

  final List<ModuleModel> _modulesInfo = const [
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
    ModuleModel(
      id: 'dressage',
      name: 'Dressage',
      description: 'Entraînement avancé, objectifs, IA comparative.',
    ),
  ];

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
        itemCount: _modulesInfo.length,
        itemBuilder: (context, index) {
          final module = _modulesInfo[index];
          final status = _statuses[module.id] ?? 'disponible';
          return ModuleCard(
            module: module,
            status: status,
            onActivate: () => _activate(module.id),
          );
        },
      ),
    );
  }
<<<<<<< HEAD
=======

>>>>>>> codex/ajouter-widget-module_card
}
