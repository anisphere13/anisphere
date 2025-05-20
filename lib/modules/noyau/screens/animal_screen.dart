/// Copilot Prompt : Écran de visualisation d’un animal dans AniSphère.
/// Affiche les données complètes d’un animal enregistré (nom, espèce, race, date, image).
/// Préparé pour afficher les modules IA, l’historique, et la fiche publique.
/// Suivi du branding AniSphère et UX à la Samsung Health.
import 'package:flutter/material.dart';
import 'package:anisphere/modules/identite/screens/identity_screen.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:hive/hive.dart';

class AnimalScreen extends StatelessWidget {
  final String name;
  final String species;
  final String breed;
  final DateTime birthDate;

  const AnimalScreen({
    super.key,
    required this.name,
    required this.species,
    required this.breed,
    required this.birthDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil de l’animal"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(Icons.pets, size: 80, color: Color(0xFF183153)),
                ),
                const SizedBox(height: 20),
                _buildRow("Nom", name),
                _buildRow("Espèce", species),
                _buildRow("Race", breed),
                _buildRow("Date de naissance",
                    "${birthDate.day}/${birthDate.month}/${birthDate.year}"),
                const SizedBox(height: 20),
                const Divider(),
                const Text("Modules IA à venir...",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF183153),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
