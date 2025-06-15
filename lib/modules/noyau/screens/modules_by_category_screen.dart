library;

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/theme.dart';

class ModulesByCategoryScreen extends StatefulWidget {
  final String category;
  const ModulesByCategoryScreen({super.key, required this.category});

  @override
  State<ModulesByCategoryScreen> createState() => _ModulesByCategoryScreenState();
}

class _ModulesByCategoryScreenState extends State<ModulesByCategoryScreen> {
  final ModulesService _service = ModulesService();
  List<ModuleModel> _modules = [];
  Map<String, String> _statuses = {};

  @override
  void initState() {
    super.initState();
    _modules = ModulesService.modules
        .where((m) => m.category == widget.category)
        .toList();
    _loadStatuses();
  }

  Future<void> _loadStatuses() async {
    final s = await _service.getAllStatuses();
    setState(() {
      _statuses = s;
    });
  }

  Future<void> _activate(String id) async {
    await _service.setActive(id);
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
          final status = _statuses[module.id] ?? 'disponible';
          return _buildModuleCard(module, status);
        },
      ),
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
