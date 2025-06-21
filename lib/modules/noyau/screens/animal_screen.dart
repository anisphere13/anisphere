// Copilot Prompt : Écran de visualisation d’un animal dans AniSphère.
// Affiche les données complètes d’un animal enregistré (nom, espèce, race, date, image).
// Intègre un bouton “Identité” vers `IdentityScreen` avec `IdentityService`.
// Préparé pour afficher les modules IA, l’historique, et la fiche publique.
// Suivi du branding AniSphère et UX à la Samsung Health.

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/identite/screens/identity_screen.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:hive/hive.dart';

class AnimalScreen extends StatelessWidget {
  final AnimalModel animal;

  const AnimalScreen({
    super.key,
    required this.animal,
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
                const Center(
                  child: Icon(Icons.pets, size: 80, color: Color(0xFF183153)),
                ),
                const SizedBox(height: 20),
                _buildRow("Nom", animal.name),
                _buildRow("Espèce", animal.species),
                _buildRow("Race", animal.breed),
                _buildRow(
                  "Date de naissance",
                  animal.birthDate != null
                      ? "${animal.birthDate!.day}/${animal.birthDate!.month}/${animal.birthDate!.year}"
                      : "Non renseignée",
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      try {
                        final identityBox =
                            Hive.box<IdentityModel>('identityBox');
                        final identityService = IdentityService(
                            localBox: identityBox, signatureSecret: 'secret');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => IdentityScreen(
                              animals: [animal],
                              service: identityService,
                            ),
                          ),
                        );
                      } catch (e) {
                        // Log uniquement en debug
                        assert(() {
                          debugPrint("❌ Erreur ouverture identité : $e");
                          return true;
                        }());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Erreur d\'accès à l\'identité'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.badge),
                    label: const Text("Identité"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF183153),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const Text("Modules IA à venir...",
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Affiche une ligne label/valeur pour une info animal.
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
