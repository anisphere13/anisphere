/// Copilot Prompt : Écran de splash pour AniSphère.
/// Vérifie si un utilisateur est déjà connecté via UserProvider.
/// Redirige automatiquement vers MainScreen ou LoginScreen.
/// Affiche une animation de chargement pendant l’analyse.

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
      await userProvider.loadUser();

      if (!mounted) return;

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
    if (!mounted) return;
    Future.microtask(() {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      }
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
