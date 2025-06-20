// Copilot Prompt : Écouteur de notifications cloud AniSphère.
// Se connecte à Firebase Messaging pour recevoir les notifications push.
// Affiche les notifications via NotificationService.
// À intégrer dans l'initialisation de l'application.


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../services/notification_service.dart';
import '../models/notification_feedback_model.dart';
import '../logic/ia_master.dart';
import 'navigation_service.dart';
import '../screens/message_list_screen.dart';
import '../screens/notifications_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudNotificationListener {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// 🔁 Initialisation complète de l’écouteur
  static Future<void> initialize() async {
    // 🔐 Demander les permissions (iOS uniquement)
    await _messaging.requestPermission();

    // 📬 Gestion des messages reçus à l’avant-plan
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "AniSphère";
      final body = message.notification?.body ?? "";

      NotificationService.showNotification(title: title, body: body);
    });

    // 📥 Gestion des messages reçus en arrière-plan (clic utilisateur)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("🔁 Notification cliquée : ${message.data}");
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final feedback = NotificationFeedbackModel(
        notificationId: message.messageId ?? '',
        userId: userId,
        openedAt: DateTime.now(),
        reaction: 'opened',
        module: message.data['module'] ?? '',
        type: message.data['type'] ?? '',
        createdAt: message.sentTime ?? DateTime.now(),
      );
      IAMaster.instance.pushNotificationFeedback(feedback);
      processNotificationData(message.data);
    });

    debugPrint("☁️ CloudNotificationListener initialisé.");
  }

  /// Handles navigation or actions based on notification content.
  static void processNotificationData(Map<String, dynamic> data) {
    final module = data['module'] as String? ?? '';
    final type = data['type'] as String? ?? '';
    if (module == 'messagerie' || type == 'message') {
      NavigationService.push(const MessageListScreen());
    } else if (module == 'noyau' || type == 'notification') {
      NavigationService.push(const NotificationsScreen());
    }
  }

  /// 🧪 Token utile pour debug / lien Firestore si besoin
  static Future<String?> getToken() async {
    final token = await _messaging.getToken();
    debugPrint("📱 Firebase Messaging Token : $token");
    return token;
  }
}
