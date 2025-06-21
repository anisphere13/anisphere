// Copilot Prompt : Service de notifications pour le noyau AniSphère.
// Permet d'envoyer des notifications locales intelligentes selon le contexte IA.
// Gère également la préparation des canaux pour l'envoi de notifications.
// Utilisable avec Firebase Messaging à terme pour le cloud.


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import '../models/notification_feedback_model.dart';
import '../logic/ia_master.dart';

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

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
        final feedback = NotificationFeedbackModel(
          notificationId: details.id?.toString() ?? '',
          userId: userId,
          openedAt: DateTime.now(),
          reaction: 'opened',
          module: '',
          type: '',
          createdAt: DateTime.now(),
        );
        IAMaster.instance.pushNotificationFeedback(feedback);
      },
    );
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
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 100);
    }
    final player = AudioPlayer();
    try {
      await player.play(AssetSource('sounds/notification.mp3'));
    } catch (_) {
      // Ignore if asset missing
    }
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

  /// 📝 Récupère les notifications en attente.
  /// TODO: ajouter test
  Future<List<String>> fetchPendingNotifications() async {
    // 🔜 Cette méthode s'appuiera sur le stockage local/cloud
    // pour retourner les notifications réelles encore non traitées.
    return [
      'Rappel vermifuge dans 3 jours',
      'Nouvelle mise à jour disponible',
      'Votre profil est incomplet',
    ];
  }
}
