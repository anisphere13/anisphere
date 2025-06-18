/// Service d'initialisation AniSphère (Firebase + Hive).
/// Gère le démarrage sécurisé et multiplateforme, avec support tests, Web et logs.
/// Initialisation des boîtes locales et de Firebase selon la plateforme.

import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:anisphere/firebase_options.dart';

class AppInitializer {
  /// 🔥 Initialise Firebase (sauf si Web déjà actif)
  static Future<void> initFirebase() async {
    if (!kIsWeb) {
      await _safeExecute(
        () async {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        },
        successMessage: "🔥 Firebase initialisé !",
        errorMessage: "❌ Échec Firebase",
      );
    } else {
      debugPrint("🌐 Web détecté — Firebase déjà actif");
    }
  }

  /// 📦 Initialise Hive et ouvre les boîtes essentielles
  static Future<void> initHive() async {
    await _safeExecute(
      () async {
        await Hive.initFlutter();
        await _openSafeBox('settings');
        await _openSafeBox('user_data');
        await _openSafeBox('offline_sync_queue');
        await _openSafeBox('offline_photo_queue');
        await _openSafeBox('photos');
        await _openSafeBox('share_history');
      },
      successMessage: "📦 Hive initialisé !",
      errorMessage: "❌ Échec Hive",
    );
  }

  /// ⚙️ Méthode principale : initialisation complète
  static Future<void> initialize() async {
    await initFirebase();
    await initHive();
  }

  /// ✅ Ouvre une boîte Hive si elle n'est pas déjà ouverte
  static Future<void> _openSafeBox(String name) async {
    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox(name);
    }
  }

  /// 🔒 Exécute une tâche en toute sécurité avec gestion des erreurs
  static Future<void> _safeExecute(
    Future<void> Function() task, {
    required String successMessage,
    required String errorMessage,
  }) async {
    try {
      await task();
      debugPrint(successMessage);
    } catch (e) {
      debugPrint("$errorMessage : $e");
    }
  }
}