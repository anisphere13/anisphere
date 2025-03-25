import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'login_screen.dart';
import 'package:anisphere/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      await userProvider.loadUser(); // Charge l'utilisateur depuis Firebase/Hive

      if (!mounted) return; // Vérifie si l'écran est toujours actif

      if (userProvider.user != null) {
        debugPrint("✅ Utilisateur connecté : ${userProvider.user!.email}");
        _navigateTo(const MainScreen());
      } else {
        debugPrint("❌ Aucun utilisateur connecté, redirection vers Login.");
        _navigateTo(const LoginScreen());
      }
    } catch (e) {
      debugPrint("❌ Erreur lors du chargement utilisateur : $e");
      if (mounted) _navigateTo(const LoginScreen());
    }
  }

  void _navigateTo(Widget screen) {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    });
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
