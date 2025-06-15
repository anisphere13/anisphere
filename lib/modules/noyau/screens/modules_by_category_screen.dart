library;

import 'package:flutter/material.dart';
import '../services/modules_service.dart';
import '../widgets/module_card.dart';

class ModulesByCategoryScreen extends StatefulWidget {
  final String category;
  final List<Map<String, String>>? modules;

  const ModulesByCategoryScreen({
    super.key,
    required this.category,
    this.modules,
  });

  @override
  State<ModulesByCategoryScreen> createState() => _ModulesByCategoryScreenState();
}

class _ModulesByCategoryScreenState extends State<ModulesByCategoryScreen> {
  final ModulesService _modulesService = ModulesService();
  List<Map<String, String>> _modules = [];
  Map<String, String> _statuses = {};

  @override
  void initState() {
    super.initState();
    if (widget.modules != null) {
      _modules = widget.modules!;
      _loadStatuses();
    } else {
      _loadModules();
    }
  }

  Future<void> _loadModules() async {
    final mods = await _modulesService.getModulesByCategory(widget.category);
    setState(() => _modules = mods);
    _loadStatuses();
  }

  Future<void> _loadStatuses() async {
    final status = await _modulesService.getAllStatuses();
    if (!mounted) return;
    setState(() => _statuses = status);
  }

  Future<void> _activate(String id) async {
    await _modulesService.setActive(id);
    _loadStatuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _modules.length,
        itemBuilder: (context, index) {
          final module = _modules[index];
          final id = module['id']!;
          final status = _statuses[id] ?? 'disponible';
          return ModuleCard(
            module: module,
            status: status,
            onActivate: () => _activate(id),
          );
        },
      ),
    );
  }
}
