/// Copilot Prompt : Écran de profil utilisateur complet pour AniSphère.
/// Affiche l’identité, les modules actifs, le statut IA premium, un QR, et des actions pratiques.
/// UX fluide inspirée Samsung Health, avec sections bien séparées.
/// Préparé pour IA, abonnements, QR, export, stats, vie privée.

library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _sectionTitle("Identité"),
          _profileRow("Nom", user.name),
          _profileRow("Email", user.email),
          _profileRow("Téléphone", user.phone),
          _profileRow("Profession", user.profession),
          const SizedBox(height: 24),

          _sectionTitle("Modules actifs"),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: user.moduleRoles.keys
                .map((module) => Chip(
                      label: Text(module),
                      backgroundColor: const Color(0xFFF5F5F5),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),

          _sectionTitle("IA & Abonnement"),
          _profileRow("IA Premium", user.iaPremium ? "Oui" : "Non"),
          _profileRow("Dernière sync IA", user.lastIASync?.toIso8601String() ?? "Jamais"),

          const SizedBox(height: 24),
          _sectionTitle("QR d'identification"),
          Center(
            child: QrImageView(
              data: user.id,
              version: QrVersions.auto,
              size: 150,
              backgroundColor: Colors.white,
            ),
          ),

          const SizedBox(height: 24),
          _sectionTitle("Actions"),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Exporter mes données"),
            onTap: () {
              // 📎 Export à implémenter
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Fonction export à venir.")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Vie privée et sécurité"),
            onTap: () {
              // 📎 Paramètres à venir
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Fonction confidentialité à venir.")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.stacked_bar_chart),
            title: const Text("Statistiques d’utilisation"),
            onTap: () {
              // 📎 Statistiques futures
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Statistiques à venir.")),
              );
            },
          ),
          const SizedBox(height: 32),
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
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF183153),
      ),
    );
  }

  Widget _profileRow(String label, String value) {
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
