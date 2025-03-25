import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../firebase_options.dart';

class AppInitializer {
  static Future<void> initialize() async {
    // Initialisation de Firebase
    if (!kIsWeb) {
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        if (kDebugMode) {
          debugPrint("🔥 Firebase initialized successfully!");
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint("❌ Firebase initialization failed: $e");
        }
      }
    } else {
      if (kDebugMode) {
        debugPrint("🚀 Exécution sur le Web - Firebase activé par défaut");
      }
    }

    // Initialisation de Hive (stockage local)
    try {
      await Hive.initFlutter();
      await Hive.openBox('settings'); // Boîte pour les préférences
      await Hive.openBox(
        'user_data',
      ); // Boîte pour stocker les infos utilisateur
      if (kDebugMode) {
        debugPrint("📦 Hive initialized successfully!");
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("❌ Hive initialization failed: $e");
      }
    }
  }
}
