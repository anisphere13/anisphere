// Copilot Prompt : Écran complet du profil utilisateur AniSphère.
// Affiche identité, modules actifs, statut IA, QR ID, actions pratiques.
// UX fluide inspirée Samsung Health, sections bien définies.
// IA-ready, QR, export, stats, confidentialité préparés.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'user_edit_screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Mon Profil")),
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
                .map(
                  (module) => Chip(
                    label: Text(module),
                    backgroundColor: const Color(0xFFF5F5F5),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),

          _sectionTitle("IA & Abonnement"),
          _profileRow("IA Premium", user.iaPremium ? "Oui ✅" : "Non ❌"),
          _profileRow(
            "Dernière sync IA",
            user.lastIASync != null
                ? "${user.lastIASync!.day}/${user.lastIASync!.month}/${user.lastIASync!.year}"
                : "Jamais",
          ),

          const SizedBox(height: 24),
          _sectionTitle("QR d'identification"),
          Center(
            child: QrImageView(
              data: user.id,
              version: QrVersions.auto,
              size: 160,
              backgroundColor: Colors.white,
              embeddedImageStyle: const QrEmbeddedImageStyle(
                size: Size(40, 40),
              ),
            ),
          ),

          const SizedBox(height: 24),
          _sectionTitle("Actions pratiques"),
          Card(
            child: Column(
              children: [
                _actionTile(
                  context,
                  icon: Icons.history,
                  title: "Exporter mes données",
                  subtitle: "Télécharger un fichier complet de vos données.",
                  action: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fonction d\'export bientôt disponible'),
                      ),
                    );
                  },
                ),
                _actionTile(
                  context,
                  icon: Icons.lock,
                  title: "Vie privée et sécurité",
                  subtitle: "Configurer vos préférences de confidentialité.",
                  action: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Paramètres de confidentialité bientôt disponibles'),
                      ),
                    );
                  },
                ),
                _actionTile(
                  context,
                  icon: Icons.bar_chart,
                  title: "Statistiques d'utilisation",
                  subtitle: "Voir les statistiques détaillées d'utilisation.",
                  action: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Statistiques bientôt disponibles'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Modifier mon compte'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const UserEditScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Se déconnecter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF183153),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final navigator = Navigator.of(context);
                await Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).signOut();
                if (context.mounted) {
                  navigator.popUntil((route) => route.isFirst);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : "Non renseigné",
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback action,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF183153)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: action,
    );
  }
}
