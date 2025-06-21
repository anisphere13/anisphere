// Copilot Prompt : Menu contextuel AniSphère (3 points vertical).
// Permet d'accéder rapidement au profil, paramètres, notifications, etc.
// Intégration prévue dans tous les écrans via AppBar > actions.

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/screens/user_profile_screen.dart';
import 'package:anisphere/modules/noyau/screens/settings_screen.dart';
import 'package:anisphere/modules/noyau/screens/notifications_screen.dart';
import 'package:anisphere/l10n/app_localizations.dart';

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'profile':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserProfileScreen()),
            );
            break;
          case 'settings':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
            break;
          case 'notifications':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            );
            break;
          case 'about':
            showAboutDialog(
              context: context,
              applicationName: 'AniSphère',
              applicationVersion: '2.0',
              applicationLegalese: '© 2025 AniSphère',
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'profile',
          child:
              Text(AppLocalizations.of(context)?.profile ?? 'Mon profil'),
        ),
        PopupMenuItem(
          value: 'settings',
          child:
              Text(AppLocalizations.of(context)?.settings ?? 'Paramètres'),
        ),
        PopupMenuItem(
          value: 'notifications',
          child: Text(
              AppLocalizations.of(context)?.notifications ?? 'Notifications'),
        ),
        PopupMenuItem(
          value: 'about',
          child: Text(AppLocalizations.of(context)?.about ?? 'À propos'),
        ),
      ],
    );
  }
}
