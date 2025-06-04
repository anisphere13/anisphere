/// Copilot Prompt : Entrée principale AniSphère.
/// Initialise Firebase, Hive avec adapters IA, providers, IA, et lance l'app.
library;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Ajouté pour la permission Android

import 'package:anisphere/firebase_options.dart';
import 'package:anisphere/modules/noyau/screens/main_screen.dart';
import 'package:anisphere/modules/noyau/screens/login_screen.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/providers/animal_provider.dart';
import 'package:anisphere/modules/noyau/providers/ia_context_provider.dart';
import 'package:anisphere/modules/noyau/providers/support_provider.dart';

import 'package:anisphere/modules/noyau/logic/ia_master.dart';
import 'package:anisphere/modules/noyau/logic/ia_executor.dart';
import 'package:anisphere/modules/noyau/logic/ia_scheduler.dart';
import 'package:anisphere/modules/noyau/services/notification_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';

// Hive Adapters pour la synchronisation différée IA
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';
import 'package:anisphere/modules/noyau/logic/ia_metrics_collector.dart';
import 'package:anisphere/services/notification_service.dart';
import 'package:anisphere/services/cloud_notification_listener.dart';

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
  CloudNotificationListener.start();

  // Demande de permission notifications Android (intégré proprement ici)
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final iaContextProvider =
        Provider.of<IAContextProvider>(context, listen: false);

    await userProvider.loadUser();

    if (!mounted) return;

    await iaContextProvider.init(
      isOffline: false,
      animalService: AnimalService(),
      userService: userProvider.userService,
    );

    final contextIA = iaContextProvider.context;

    final iaExecutor = IAExecutor(
      iaMaster: IAMaster.instance,
      notificationService: NotificationService(),
      modulesService: ModulesService(),
      animalService: AnimalService(),
    );

    final iaScheduler = IAScheduler(
      executor: iaExecutor,
      iaMaster: IAMaster.instance,
      user: userProvider.user!, // ✅ nécessaire pour la sync cloud
    );

    iaScheduler.start(contextIA);

    final Widget nextScreen =
        userProvider.user != null ? const MainScreen() : const LoginScreen();

    assert(() {
      debugPrint(
        userProvider.user != null
            ? "✅ Utilisateur connecté, redirection vers MainScreen"
            : "❌ Aucun utilisateur connecté, redirection vers LoginScreen",
      );
      return true;
    }());

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Chargement d'AniSphère..."),
          ],
        ),
      ),
    );
  }
}
// ⚠️ SUPPRESSION : doublon de main() et appel hors contexte Flutter (voir plus haut)
// La fonction main() et l'appel à NotificationService/CloudNotificationListener sont déjà gérés plus haut.
// L'appel direct à FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation... est maintenant intégré proprement dans main().
