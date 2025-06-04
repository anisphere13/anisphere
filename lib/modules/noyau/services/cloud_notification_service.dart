/// Copilot Prompt : Service de notifications cloud AniSphère.
/// Permet au superadmin d’envoyer des notifications push via Firebase (Firestore).
/// Utilisé par NotificationAdminScreen et IA maîtresse (alertes IA globales).

library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CloudNotificationService {
  final _firestore = FirebaseFirestore.instance;

  /// 🔔 Envoie une notification admin vers Firestore (cloud function ou listener FCM)
  Future<void> sendAdminNotification({
    required String title,
    required String body,
    String type = 'info', // 'alert', 'promo', etc.
    String? module,
    String? userId,
    String? role,
  }) async {
    try {
      await _firestore.collection('admin_notifications').add({
        'title': title,
        'body': body,
        'type': type,
        'module': module,
        'targetUserId': userId,
        'targetRole': role,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint("\ud83d\udce4 Notification cloud envoy\u00e9e : \$title");
    } catch (e) {
      debugPrint("\u274c [CloudNotificationService] Erreur : \$e");
    }
  }
}
