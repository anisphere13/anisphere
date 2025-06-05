// Copilot Prompt : Outils avancés pour les notifications AniSphère (admin).
// Affiche l’historique des notifications envoyées, permet de gérer des brouillons,
// tester localement et envoyer à des groupes personnalisés.

library;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class NotificationHistoryScreen extends StatelessWidget {
  const NotificationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user?.role != "superadmin") {
      return const Scaffold(
        body: Center(child: Text("🔒 Accès refusé")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Historique des notifications envoyées")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('admin_notifications')
            .orderBy('timestamp', descending: true)
            .limit(50)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Aucune notification envoyée récemment."));
          }

          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: const Icon(Icons.notifications_active),
                title: Text(data['title'] ?? 'Sans titre'),
                subtitle: Text("${data['body'] ?? ''}\nModule : ${data['module'] ?? 'global'} | Type : ${data['type'] ?? 'info'}"),
                trailing: Text(
                  DateTime.fromMillisecondsSinceEpoch(data['timestamp']?.millisecondsSinceEpoch ?? 0)
                      .toLocal()
                      .toString()
                      .substring(0, 16),
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
