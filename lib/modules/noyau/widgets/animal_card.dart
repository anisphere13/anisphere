// Copilot Prompt : Widget AnimalCard pour AniSphère.
// Affiche un animal sous forme de carte élégante avec image, nom, espèce.
// Utilisé dans la liste des animaux, l'accueil et les modules IA.

library;

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

class AnimalCard extends StatelessWidget {
  final AnimalModel animal;
  final VoidCallback? onTap;

  const AnimalCard({
    super.key,
    required this.animal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: animal.imageUrl.isNotEmpty
                      ? NetworkImage(animal.imageUrl)
                      : const AssetImage("assets/images/placeholder.png")
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animal.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${animal.species} • ${animal.breed}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
