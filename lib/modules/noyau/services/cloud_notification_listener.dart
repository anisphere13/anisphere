// Copilot Prompt : Écouteur de notifications cloud AniSphère.
// Se connecte à Firebase Messaging pour recevoir les notifications push.
// Affiche les notifications via NotificationService.
// À intégrer dans l'initialisation de l'application.

library;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../services/notification_service.dart';

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
      // TODO : Ajouter redirection ou comportement contextuel
    });

    debugPrint("☁️ CloudNotificationListener initialisé.");
  }

  /// 🧪 Token utile pour debug / lien Firestore si besoin
  static Future<String?> getToken() async {
    final token = await _messaging.getToken();
    debugPrint("📱 Firebase Messaging Token : $token");
    return token;
  }
}
