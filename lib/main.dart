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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Initialisation de Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("🔥 Firebase initialized successfully!");
  } catch (e) {
    debugPrint("❌ Firebase initialization failed: $e");
  }

  // 📦 Initialisation de Hive pour le stockage local
  try {
    await Hive.initFlutter();
    await LocalStorageService.init();
    debugPrint("📦 Hive initialized successfully!");
  } catch (e) {
    debugPrint("❌ Hive initialization failed: $e");
  }

  // 🔄 Initialisation des services
  final userService = UserService();
  final authService = AuthService();
  
  try {
    await userService.init(); // ✅ Ajout de la gestion des erreurs
  } catch (e) {
    debugPrint("❌ Erreur d'initialisation de UserService : $e");
  }

  // 🚀 Lancement de l'application
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(userService, authService),
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
      debugShowCheckedModeBanner: false,
      title: 'AniSphère',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(), // Démarrage sur l'écran de chargement
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

    final Widget nextScreen = userProvider.user != null
        ? const MainScreen()
        : const LoginScreen();

    debugPrint(userProvider.user != null
        ? "✅ Utilisateur connecté, redirection vers MainScreen"
        : "❌ Aucun utilisateur connecté, redirection vers LoginScreen");

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
