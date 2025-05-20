/// Copilot Prompt : Écran de profil utilisateur pour AniSphère.
/// Affiche les infos personnelles, modules actifs et boutons d'action.
/// Préparé pour extensions IA, export, QR et statistiques à venir.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Aucun utilisateur connecté.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Informations personnelles",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF183153),
              ),
            ),
            const SizedBox(height: 12),
            _buildProfileRow("Nom", user.name),
            _buildProfileRow("Email", user.email),
            _buildProfileRow("Téléphone", user.phone),
            _buildProfileRow("Profession", user.profession),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              "Modules actifs",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF183153),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: user.moduleRoles.keys
                  .map((m) => Chip(
                        label: Text(m),
                        backgroundColor: const Color(0xFFF5F5F5),
                      ))
                  .toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Se déconnecter"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF183153),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await Provider.of<UserProvider>(context, listen: false).signOut();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF183153),
            ),
          ),
          Expanded(
            child: Text(value.isNotEmpty ? value : "Non renseigné"),
          ),
        ],
      ),
    );
  }
}
