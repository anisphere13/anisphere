// Copilot Prompt : Entrée principale AniSphère.
// Initialise Firebase, Hive avec adapters IA, providers, IA, et lance l'app.
library;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Ajouté pour la permission Android
import 'package:anisphere/firebase_options.dart';

import 'package:anisphere/modules/noyau/screens/splash_screen.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/providers/animal_provider.dart';
import 'package:anisphere/modules/noyau/providers/ia_context_provider.dart';
import 'package:anisphere/modules/noyau/providers/support_provider.dart';

import 'package:anisphere/modules/noyau/services/notification_service.dart';

// Hive Adapters pour la synchronisation différée IA
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';
import 'package:anisphere/modules/noyau/logic/ia_metrics_collector.dart';
import 'package:anisphere/modules/noyau/services/cloud_notification_listener.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    assert(() {
      debugPrint("🔥 Firebase initialized successfully!");
      return true;
    }());
  } catch (e) {
    assert(() {
      debugPrint("❌ Firebase initialization failed: $e");
      return true;
    }());
  }
  try {
    await Hive.initFlutter();
    // Enregistrement des adapters Hive nécessaires
    Hive.registerAdapter(SyncTaskAdapter());
    Hive.registerAdapter(IAMetricAdapter());
    await LocalStorageService.init();
    assert(() {
      debugPrint("📦 Hive initialized successfully!");
      return true;
    }());
  } catch (e) {
    assert(() {
      debugPrint("❌ Hive initialization failed: $e");
      return true;
    }());
  }
  await NotificationService.initialize();
  CloudNotificationListener.initialize();  // Demande de permission notifications Android (intégré proprement ici)
  final plugin = FlutterLocalNotificationsPlugin();
  final androidPlugin =
      plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await androidPlugin?.requestNotificationsPermission();
  assert(() {
    debugPrint("🧠 Initialisation services IA terminée !");
    return true;
  }());
  final userService = UserService();
  final authService = AuthService();
  try {
    await userService.init();
  } catch (e) {
    assert(() {
      debugPrint("❌ Erreur d'initialisation de UserService : $e");
      return true;
    }());
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(userService, authService),
        ),
        ChangeNotifierProvider(
          create: (_) => AnimalProvider()..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => IAContextProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SupportProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AniSphère',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF183153),
          primary: const Color(0xFF183153),
          secondary: const Color(0xFFFBC02D),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF183153),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF3A3A3A)),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
