library;

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/widgets/module_card.dart';

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
  final ModulesService _service = ModulesService();
  List<Map<String, String>> _modules = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (widget.modules != null) {
      _modules = widget.modules!;
      _loading = false;
    } else {
      _loadModules();
    }
  }

  Future<void> _loadModules() async {
    final result = await _service.getModulesByCategory(widget.category);
    if (!mounted) return;
    setState(() {
      _modules = result;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _modules.length,
              itemBuilder: (context, index) {
                final module = _modules[index];
                return ModuleCard(
                  name: module['name'] ?? '',
                  description: module['description'],
                );
              },
            ),
    );
  }
}
