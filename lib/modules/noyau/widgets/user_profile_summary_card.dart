import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import '../screens/settings_screen.dart';
import '../i18n/app_localizations.dart';
import 'package:provider/provider.dart';

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
    final t = AppLocalizations.of(context)!;
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
                  Text(
                    t.profile_incomplete_title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t.profile_incomplete_message,
                    style: const TextStyle(color: Colors.white),
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
              child: Text(t.profile_update_button),
            )
          ],
        ),
      ),
    );
  }
}
