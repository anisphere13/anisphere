/// Copilot Prompt : Écran de profil détaillé d’un animal pour AniSphère.
/// Affiche les infos de l’animal, photo, espèce, race, date.
/// Intègre des sections IA (actions personnalisées, stats), modules actifs,
/// et une future timeline (santé, éducation, dressage, etc.).
/// Prêt pour évolutions IA cloud + formations IA premium.

library;

library;

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/widgets/ia_chip.dart';
import 'package:anisphere/modules/noyau/widgets/ia_suggestion_card.dart';

class AnimalProfileScreen extends StatelessWidget {
  final AnimalModel animal;

  const AnimalProfileScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPhotoSection(animal),
          const SizedBox(height: 16),
          _buildInfoRow("Espèce", animal.species),
          _buildInfoRow("Race", animal.breed),
          _buildInfoRow(
            "Date d'ajout",
            "${animal.createdAt.day}/${animal.createdAt.month}/${animal.createdAt.year}",
          ),
          _buildInfoRow(
            "Dernière mise à jour",
            "${animal.updatedAt.day}/${animal.updatedAt.month}/${animal.updatedAt.year}",
          ),
          const SizedBox(height: 16),
          const Divider(),
          const Text(
            "Modules actifs",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: const [
              IAChip(label: "Suivi santé", icon: Icons.healing),
              IAChip(label: "Éducation", icon: Icons.psychology_alt),
              IAChip(label: "Fugue/QR", icon: Icons.qr_code),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "Suggestions IA",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          IASuggestionCard(
            title: "Activité à revoir",
            message: "Promenades trop espacées cette semaine. Essayez d’ajuster.",
            icon: Icons.directions_walk,
          ),
          IASuggestionCard(
            title: "Vaccins",
            message: "Prochaine vérification vétérinaire recommandée sous 30 jours.",
            icon: Icons.medical_services,
          ),
          const SizedBox(height: 24),
          const Text(
            "Historique (à venir)",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            "Cette section affichera bientôt les événements santé, entraînements, alertes IA, etc.",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSection(AnimalModel animal) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: animal.imageUrl.isNotEmpty
            ? Image.network(animal.imageUrl, width: 120, height: 120, fit: BoxFit.cover)
            : Image.asset("assets/images/placeholder.png", width: 120, height: 120),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text("$label : ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value.isNotEmpty ? value : "Non renseigné")),
        ],
      ),
    );
  }
}
