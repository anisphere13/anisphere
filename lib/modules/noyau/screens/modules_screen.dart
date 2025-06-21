// Copilot Prompt : Écran des modules dans AniSphère.
// Affiche les modules disponibles avec cartes claires (nom, description, statut).
// Préparé pour activer, acheter ou découvrir chaque module.
// Inspiré de l’ergonomie Samsung Health.
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/widgets/module_card.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/identite/screens/identity_screen.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:hive/hive.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({super.key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  final ModulesService _modulesService = ModulesService();
  final Map<String, List<ModuleModel>> _modulesByCategory = {};

  Map<String, String> _statuses = {};

  @override
  void initState() {
    super.initState();
    for (final m in ModulesService.modules) {
      _modulesByCategory.putIfAbsent(m.category, () => []).add(m);
    }
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

  Future<void> _handleTap(ModuleModel module) async {
    if (module.id != 'identite') return;

    try {
      final animals = await AnimalService().getAllAnimals();
      if (animals.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aucun animal enregistré')),
        );
        return;
      }

      final identityBox = Hive.box<IdentityModel>('identityBox');
      final identityService = IdentityService(localBox: identityBox);

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              IdentityScreen(animal: animals.first, service: identityService),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur d'accès à l'identité.")),
      );
    }
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
                    final id = module.id;
                    final status = _statuses[id] ?? 'disponible';
                    return SizedBox(
                      width: 220,
                      child: ModuleCard(
                        module: module,
                        status: status,
                        onActivate: () => _activate(id),
                        onTap: () => _handleTap(module),
                        badge: module.premium
                            ? null
                            : const Text(
                                'Gratuit',
                                style: TextStyle(color: Colors.green),
                              ),
                      ),
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
}
