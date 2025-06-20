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
import '../../../theme.dart';
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
    _modulesByCategory.putIfAbsent('Communauté', () => []);
    _loadStatuses();
  }

  Future<void> _loadStatuses() async {
    final status = await _modulesService.getAllStatuses();
    if (!mounted) return;
    setState(() {
      _statuses = status;
    });
  }

  Future<void> _activate(String id) async {
    if (!ModulesService.isActive(id)) {
      await _modulesService.setActive(id);
      _loadStatuses();
    }
  }

  Future<void> _openIdentityScreen() async {
    try {
      final animalService = AnimalService();
      await animalService.init();
      final box = await animalService.getLocalBox();
      if (box.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Aucun animal disponible')),
          );
        }
        return;
      }
      final animal = box.values.first;
      if (!Hive.isBoxOpen('identityBox')) {
        await Hive.openBox<IdentityModel>('identityBox');
      }
      final identityBox = Hive.box<IdentityModel>('identityBox');
      final identityService =
          IdentityService(localBox: identityBox, signatureSecret: 'secret');
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              IdentityScreen(animals: [animal], service: identityService),
        ),
      );
    } catch (e) {
      debugPrint("Erreur ouverture identite: $e");
    }

  }

  Widget _buildModulesCommunaute() {
    final modules = _modulesByCategory['Communauté'] ?? [];
    if (modules.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Communauté",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: modules.length,
            itemBuilder: (context, idx) {
              final module = modules[idx];
              if (module.id == 'identite' && !ModulesService.isActive('identite')) {
                return const SizedBox.shrink();
              }
              final status = _statuses[module.id] ?? 'disponible';
              return SizedBox(
                width: 220,
                child: ModuleCard(
                  module: module,
                  status: status,
                  onActivate: () => _activate(module.id),
                  onTap: module.id == 'identite' ? _openIdentityScreen : null,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Future<void> _handleTap(ModuleModel module) async {
    if (module.id != 'identite') return;

    try {
      final animals = await AnimalService().getAllAnimals();
      if (animals.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text('Aucun animal enregistré')), 
        );
        return;
      }
      if (!Hive.isBoxOpen('identityBox')) {
        await Hive.openBox<IdentityModel>('identityBox');
      }

      final identityBox = Hive.box<IdentityModel>('identityBox');
      final identityService =
          IdentityService(localBox: identityBox, signatureSecret: 'secret');

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              IdentityScreen(animals: animals, service: identityService),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Erreur d\'accès à l\'identité')), 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ..._modulesByCategory.entries
              .where((e) => e.key != 'Communauté')
              .map((entry) {
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
                                style: TextStyle(color: primaryBlue),
                              ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
          }),
          _buildModulesCommunaute(),
        ],
      ),
    );
  }
}
