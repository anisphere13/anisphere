// Copilot Prompt : Service de notifications pour le noyau AniSphère.
// Permet d'envoyer des notifications locales intelligentes selon le contexte IA.
// Gère également la préparation des canaux pour l'envoi de notifications.
// Utilisable avec Firebase Messaging à terme pour le cloud.

library;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 📦 Initialisation des canaux de notifications
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(settings);
    debugPrint("🔔 Notifications initialisées !");
  }

  /// 📢 Notification locale simple
  static Future<void> showNotification({
    required String title,
    required String body,
    int id = 0,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'anisphere_channel',
      'AniSphère',
      channelDescription: 'Notifications générales AniSphère',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(id, title, body, platformDetails);
    debugPrint("📨 Notification affichée : $title");
  }

  /// 📬 Méthode compatible IAExecutor : notification automatique
  Future<void> sendLocalNotification({required String title, required String body}) async {
    await showNotification(title: title, body: body);
  }

  /// 🔕 Supprimer une notification programmée
  static Future<void> cancel(int id) async {
    await _notificationsPlugin.cancel(id);
    debugPrint("❌ Notification supprimée : $id");
  }

  /// 🔄 Supprimer toutes les notifications
  static Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
    debugPrint("❌ Toutes les notifications supprimées.");
  }
}
