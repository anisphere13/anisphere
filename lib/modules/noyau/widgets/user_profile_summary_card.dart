import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';
import '../models/user_model.dart';

/// Carte compacte rappelant de compléter son profil utilisateur.
class UserProfileSummaryCard extends StatelessWidget {
  final UserModel user;
  final bool proValidated;

  const UserProfileSummaryCard({
    super.key,
    required this.user,
    required this.proValidated,
  });

  bool get needsUpdate =>
      user.phone.isEmpty || user.profession.isEmpty || !proValidated;

  @override
  Widget build(BuildContext context) {
    if (!needsUpdate) return const SizedBox.shrink();
    return Card(
      color: const Color(0xFF183153),
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profil incomplet',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mettez à jour votre téléphone, adresse ou profession.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: const Text('Mettre à jour'),
            )
          ],
        ),
      ),
    );
  }
}
