/// Copilot Prompt : Écran de profil utilisateur complet pour AniSphère.
/// Affiche identité, modules actifs, statut IA premium, QR ID, et actions pratiques.
/// UX inspirée Samsung Health, sections clairement séparées.
/// Préparé pour IA, abonnements, QR, export, statistiques et confidentialité.

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
          _profileRow("Dernière sync IA",
              user.lastIASync?.toLocal().toString().split('.').first ?? "Jamais"),
          const SizedBox(height: 24),

          _sectionTitle("QR d'identification"),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: QrImageView(
                data: user.id,
                version: QrVersions.auto,
                size: 150,
                backgroundColor: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 24),
          _sectionTitle("Actions"),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Exporter mes données"),
            trailing: const Icon(Icons.chevron_right),
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
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // 📎 Paramètres confidentialité à venir
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Fonction confidentialité à venir.")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Statistiques d’utilisation"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // 📎 Statistiques futures à implémenter
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
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🏷️ Widget titre de section standardisé
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF183153),
        ),
      ),
    );
  }

  /// 📌 Ligne d’information utilisateur standardisée
  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label :",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF183153),
              ),
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
