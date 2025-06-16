// Copilot Prompt : Entrée principale AniSphère.
// Initialise Firebase, Hive avec adapters IA, providers, IA, et lance l'app.
library;

import 'package:flutter/material.dart';
import 'package:anisphere/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:anisphere/firebase_options.dart';
import 'package:anisphere/modules/noyau/screens/main_screen.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/providers/animal_provider.dart';
import 'package:anisphere/modules/noyau/providers/ia_context_provider.dart';
import 'package:anisphere/modules/noyau/providers/support_provider.dart';
import 'package:anisphere/modules/noyau/providers/messaging_provider.dart';
import 'package:anisphere/modules/noyau/services/notification_service.dart';
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';
import 'package:anisphere/modules/noyau/logic/ia_metrics_collector.dart';
import 'package:anisphere/modules/noyau/services/cloud_notification_listener.dart';
import 'package:anisphere/modules/noyau/services/navigation_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';
import 'package:anisphere/modules/noyau/models/support_ticket_model.dart';
import 'package:anisphere/modules/noyau/models/message_model.dart';
import 'package:anisphere/modules/noyau/models/conversation_model.dart';
import 'package:anisphere/modules/noyau/services/offline_message_queue.dart';
import 'package:anisphere/modules/noyau/providers/photo_provider.dart';
import 'package:anisphere/modules/noyau/models/photo_model.dart';
import 'package:anisphere/modules/noyau/models/sync_metrics_model.dart';
import 'package:anisphere/modules/noyau/services/offline_photo_queue.dart'
    as offline_queue;
import 'package:anisphere/modules/noyau/models/share_history_model.dart';
import 'package:anisphere/modules/noyau/providers/feedback_options_provider.dart';
import 'package:anisphere/modules/noyau/providers/payment_provider.dart';

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
    Hive.registerAdapter(SupportTicketTypeAdapter());
    Hive.registerAdapter(SupportTicketStatusAdapter());
    Hive.registerAdapter(SupportTicketModelAdapter());
    Hive.registerAdapter(MessageModelAdapter());
    Hive.registerAdapter(QueuedMessageAdapter());
    Hive.registerAdapter(ConversationModelAdapter());
    Hive.registerAdapter(PhotoModelAdapter());
    Hive.registerAdapter(SyncMetricsModelAdapter());
    Hive.registerAdapter(offline_queue.PhotoTaskAdapter());
    Hive.registerAdapter(ShareHistoryModelAdapter());
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
    rethrow; // Bonne pratique : rethrow pour crash early si Hive critique
  }
  await IAMaster.instance.processOfflineQueue(); // TODO: ajouter test
  assert(() {
    debugPrint("🔄 File offline traitée au démarrage");
    return true;
  }());
  await NotificationService.initialize();
  CloudNotificationListener.initialize();
  // Demande de permission notifications Android (intégré proprement ici)
  final plugin = FlutterLocalNotificationsPlugin();
  final androidPlugin = plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();
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
    rethrow; // Crash early si UserService critique
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(userService, authService),
        ),
        ChangeNotifierProvider(create: (_) => AnimalProvider()..init()),
        ChangeNotifierProvider(create: (_) => IAContextProvider()),
        ChangeNotifierProvider(create: (_) => SupportProvider()),
        ChangeNotifierProvider(create: (_) => MessagingProvider()..init()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()..init()),
        ChangeNotifierProvider(
          create: (_) => FeedbackOptionsProvider()..load(),
        ),
        ChangeNotifierProvider(create: (_) => PaymentProvider()..init()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Providers are available here; load the current user after init.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<UserProvider>(context, listen: false).loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'AniSphère',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MainScreen(),
    );
  }
}
