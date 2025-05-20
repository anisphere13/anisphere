/// Copilot Prompt : Écran de liste des animaux pour AniSphère.
/// Affiche les animaux enregistrés par l’utilisateur, ou une suggestion IA si aucun.
/// Inclut un bouton flottant “+” pour ajouter un animal manuellement.
/// Préparé pour une future vue scrollable avec raccourcis (inspirée Samsung Health).
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/screens/animal_form_screen.dart';
import 'package:anisphere/modules/noyau/widgets/ia_suggestion_card.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  final List<Map<String, dynamic>> animals = []; // Remplacer par un vrai modèle plus tard

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes animaux")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF183153),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AnimalFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: animals.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: IASuggestionCard(
                title: "Aucun animal enregistré",
                message: "Ajoutez un animal pour commencer le suivi intelligent.",
                icon: Icons.pets,
                actionLabel: "Ajouter maintenant",
                onAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AnimalFormScreen()),
                  );
                },
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: animals.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, index) {
                final animal = animals[index];
                return ListTile(
                  leading: const Icon(Icons.pets),
                  title: Text(animal["name"]),
                  subtitle: Text(animal["species"]),
                  onTap: () {
                    // Aller vers le profil animal
                  },
                );
              },
            ),
    );
  }
}
