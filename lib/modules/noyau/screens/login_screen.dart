// Copilot Prompt : Écran de connexion pour AniSphère.
// Permet de se connecter avec email, Google ou Apple.
// Utilise UserProvider, redirige vers MainScreen.
// Affiche erreurs et loading intelligemment.
// Inclut bouton vers création de compte.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'register_screen.dart';
import 'package:anisphere/modules/noyau/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login(BuildContext context) async {
    final navigator = Navigator.of(context);
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final auth = Provider.of<UserProvider>(context, listen: false).authService;
    if (!await auth.verifyBiometric()) {
      if (!context.mounted) return;
      setState(() {
        _errorMessage = "Authentification biométrique requise.";
        _isLoading = false;
      });
      return;
    }

    if (!context.mounted) return;

    final success = await Provider.of<UserProvider>(context, listen: false)
        .signInWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (!success) {
      setState(() {
        _errorMessage = "Email ou mot de passe incorrect.";
        _isLoading = false;
      });
      return;
    }

    navigator.pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  Future<void> _loginWithGoogle(BuildContext context) async {
    final navigator = Navigator.of(context);
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final auth = Provider.of<UserProvider>(context, listen: false).authService;
    if (!await auth.verifyBiometric()) {
      if (!context.mounted) return;
      setState(() {
        _errorMessage = "Authentification biométrique requise.";
        _isLoading = false;
      });
      return;
    }

    if (!context.mounted) return;

    final success = await Provider.of<UserProvider>(context, listen: false)
        .signInWithGoogle();

    if (!mounted) return;

    if (!success) {
      setState(() {
        _errorMessage = "Connexion Google échouée.";
        _isLoading = false;
      });
      return;
    }

    navigator.pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  Future<void> _loginWithApple(BuildContext context) async {
    final navigator = Navigator.of(context);
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final auth = Provider.of<UserProvider>(context, listen: false).authService;
    if (!await auth.verifyBiometric()) {
      if (!context.mounted) return;
      setState(() {
        _errorMessage = "Authentification biométrique requise.";
        _isLoading = false;
      });
      return;
    }

    if (!context.mounted) return;

    final success = await Provider.of<UserProvider>(context, listen: false)
        .signInWithApple();

    if (!mounted) return;

    if (!success) {
      setState(() {
        _errorMessage = "Connexion Apple échouée.";
        _isLoading = false;
      });
      return;
    }

    navigator.pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Mot de passe"),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _login(context),
                        child: const Text("Connexion"),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.login),
                        onPressed: () => _loginWithGoogle(context),
                        label: const Text("Connexion avec Google"),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.apple),
                        onPressed: () => _loginWithApple(context),
                        label: const Text("Connexion avec Apple"),
                      ),
                      TextButton(
                        onPressed: () {
                          if (mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          }
                        },
                        child: const Text("Créer un compte"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
