/// Copilot Prompt : Écran Mes Animaux pour AniSphère.
/// Affiche la liste des animaux de l’utilisateur depuis Hive (AnimalService).
/// Permet d’ajouter un nouvel animal (FAB).
/// Utilise FutureBuilder et Card pour l’affichage.
/// IA-ready et testable plus tard.
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  final AnimalService _animalService = AnimalService();

  @override
  void initState() {
    super.initState();
    _animalService.init();
  }

  Future<List<AnimalModel>> _loadAnimals() async {
    final box = await Hive.openBox<AnimalModel>('animal_data');
    return box.values.toList();
  }

  void _onAddAnimal() {
    // TODO: Naviguer vers écran de création d'animal
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🔧 Fonction "Ajouter un animal" à venir')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes Animaux")),
      body: FutureBuilder<List<AnimalModel>>(
        future: _loadAnimals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final animals = snapshot.data ?? [];

          if (animals.isEmpty) {
            return const Center(child: Text("Aucun animal enregistré."));
          }

          return ListView.builder(
            itemCount: animals.length,
            itemBuilder: (context, index) {
              final animal = animals[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.pets),
                  title: Text(animal.name),
                  subtitle: Text("${animal.species} - ${animal.breed}"),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddAnimal,
        child: const Icon(Icons.add),
        tooltip: "Ajouter un animal",
      ),
    );
  }
}
