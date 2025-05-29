import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ✅ Utilisation des bons chemins d'import
import 'package:anisphere/firebase_options.dart';
import 'package:anisphere/modules/noyau/screens/main_screen.dart';
import 'package:anisphere/modules/noyau/screens/login_screen.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/providers/animal_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("🔥 Firebase initialized successfully!");
  } catch (e) {
    debugPrint("❌ Firebase initialization failed: $e");
  }

  // 📦 Hive
  try {
    await Hive.initFlutter();
    await LocalStorageService.init();
    debugPrint("📦 Hive initialized successfully!");
  } catch (e) {
    debugPrint("❌ Hive initialization failed: $e");
  }

  // 🔄 Services
  final userService = UserService();
  final authService = AuthService();
  try {
    await userService.init();
  } catch (e) {
    debugPrint("❌ Erreur d'initialisation de UserService : $e");
  }

  // 🚀 App
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(userService, authService),
      ),
      ChangeNotifierProvider(
        create: (_) => AnimalProvider()..init(),
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
          seedColor: const Color(0xFF183153), // Bleu nuit
          primary: const Color(0xFF183153),
          secondary: const Color(0xFFFBC02D), // Jaune solaire
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

// 🔄 **Écran de chargement pendant l'initialisation**
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
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simule un temps de chargement

    if (!mounted) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUser(); // Charge l'utilisateur

    if (!mounted) return;

    final Widget nextScreen =
        userProvider.user != null ? const MainScreen() : const LoginScreen();

    debugPrint(
      userProvider.user != null
          ? "✅ Utilisateur connecté, redirection vers MainScreen"
          : "❌ Aucun utilisateur connecté, redirection vers LoginScreen",
    );

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
