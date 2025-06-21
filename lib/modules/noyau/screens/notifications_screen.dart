// Copilot Prompt : Écran des notifications AniSphère.
// Liste toutes les notifications IA et système.
// Trie les messages par modules et par date.
// Prévu pour une extension IA intelligente (filtrage, urgences…).

import 'package:flutter/material.dart';
import '../../../theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // 🔧 Exemple de notifications simulées
  Map<String, List<Map<String, String>>> getSampleNotifications() {
    return {
      'Santé': [
        {'title': 'Vaccin à jour', 'date': '2025-05-20'},
        {'title': 'Rappel vermifuge dans 3 jours', 'date': '2025-05-18'},
      ],
      'Éducation': [
        {'title': 'Nouvelle technique apprise : Rappel', 'date': '2025-05-19'},
      ],
      'Dressage': [
        {'title': 'Séance réussie : Pistage #4', 'date': '2025-05-17'},
      ],
      'Communauté': [
        {'title': 'Nouveau message sur votre post', 'date': '2025-05-18'},
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final notifications = getSampleNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView(
        children: notifications.entries.map((entry) {
          final moduleName = entry.key;
          final moduleNotifications = entry.value;

          return ExpansionTile(
            title: Text(
              moduleName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
            ),
            children: moduleNotifications.map((notif) {
              return ListTile(
                leading: const Icon(Icons.notification_important_outlined),
                title: Text(notif['title'] ?? ""),
                subtitle: Text("📅 ${notif['date']}"),
              );
            }).toList(), // Codex: Correction automatique flutter analyze
          );
        }).toList(), // Codex: Correction automatique flutter analyze
      ),
    );
  }
}
