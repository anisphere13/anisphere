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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileRow("Nom", user.name),
            _buildProfileRow("Email", user.email),
            _buildProfileRow("Téléphone", user.phone),
            _buildProfileRow("Profession", user.profession),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text("Modules actifs :", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: user.moduleRoles.keys.map((m) => Chip(label: Text(m))).toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await Provider.of<UserProvider>(context, listen: false).signOut();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                label: const Text("Se déconnecter"),
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
          Text("$label : ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value.isNotEmpty ? value : "Non renseigné")),
        ],
      ),
    );
  }
}
