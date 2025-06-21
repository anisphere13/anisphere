// Copilot Prompt : Écran de liste des animaux pour AniSphère.
// Affiche les animaux depuis AnimalService (Hive), sous forme de cartes.
// Montre une suggestion IA si aucun animal n’est enregistré.
// Utilise le widget AnimalCard. Prévu pour accueil type Samsung Health.
// Préparé pour intégration IA contextuelle future par animal.


import 'package:flutter/material.dart';
import '../../../theme.dart';
import 'package:anisphere/modules/noyau/screens/animal_form_screen.dart';
import 'package:anisphere/modules/noyau/screens/animal_profile_screen.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/widgets/animal_card.dart';
import 'package:anisphere/modules/noyau/widgets/ia_suggestion_card.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  final AnimalService _animalService = AnimalService();
  late Future<List<AnimalModel>> _animalsFuture;

  @override
  void initState() {
    super.initState();
    _animalsFuture = _loadAnimals();
  }

  Future<List<AnimalModel>> _loadAnimals() async {
    try {
      await _animalService.init();
      final box = await _animalService.getLocalBox();
      return box.values.toList();
    } catch (e) {
      assert(() {
        debugPrint("❌ Erreur chargement animaux : $e");
        return true;
      }());
      return [];
    }
  }

  Future<void> _refreshAnimals() async {
    setState(() {
      _animalsFuture = _loadAnimals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AnimalModel>>( 
      future: _animalsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final animals = snapshot.data ?? [];

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnimalFormScreen()),
              );
              await _refreshAnimals();
            },
            child: const Icon(Icons.add),
          ),
          body: animals.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: IASuggestionCard(
                    title: "Aucun animal enregistré",
                    message:
                        "Ajoutez un animal pour commencer le suivi intelligent.",
                    icon: Icons.pets,
                    actionLabel: "Ajouter maintenant",
                    onAction: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AnimalFormScreen()),
                      );
                      await _refreshAnimals();
                    },
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final animal = animals[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: AnimalCard(
                                animal: animal,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          AnimalProfileScreen(animal: animal),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          childCount: animals.length,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
