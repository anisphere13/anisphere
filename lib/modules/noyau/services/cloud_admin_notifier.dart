/// Copilot Prompt : AniSphère cloud notification manager for superadmin.
/// Permet d’envoyer des notifications cloud ciblées ou globales via Firestore.
/// Prévu pour une Firebase Function ou une lecture client-side en background.
/// Utilisé par le superadmin uniquement.

library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CloudAdminNotifier {
  static final _collection = FirebaseFirestore.instance.collection('notifications');

  /// 🔔 Envoie une notification globale à tous les utilisateurs
  static Future<void> sendGlobalNotification({
    required String title,
    required String message,
    String? category,
  }) async {
    try {
      await _collection.add({
        'type': 'global',
        'title': title,
        'message': message,
        'category': category ?? 'info',
        'timestamp': DateTime.now().toIso8601String(),
      });
      debugPrint("📣 Notification globale envoyée : $title");
    } catch (e) {
      debugPrint("❌ [CloudAdminNotifier] Erreur globale : $e");
    }
  }

  /// 🎯 Notification ciblée (par ID utilisateur)
  static Future<void> sendToUser(String userId, {
    required String title,
    required String message,
    String? category,
  }) async {
    try {
      await _collection.add({
        'type': 'user',
        'userId': userId,
        'title': title,
        'message': message,
        'category': category ?? 'custom',
        'timestamp': DateTime.now().toIso8601String(),
      });
      debugPrint("📨 Notification ciblée envoyée à $userId");
    } catch (e) {
      debugPrint("❌ [CloudAdminNotifier] Erreur ciblée : $e");
    }
  }
}
