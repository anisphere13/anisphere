// Copilot Prompt : Écran pour activer l'authentification biométrique dans AniSphère.

import 'package:flutter/material.dart';
import '../services/biometric_service.dart';

class BiometricSetupScreen extends StatefulWidget {
  const BiometricSetupScreen({super.key});

  @override
  State<BiometricSetupScreen> createState() => _BiometricSetupScreenState();
}

class _BiometricSetupScreenState extends State<BiometricSetupScreen> {
  final BiometricService _service = BiometricService();
  bool _available = false;
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _checkAvailability();
  }

  Future<void> _checkAvailability() async {
    final canCheck = await _service.canCheckBiometrics();
    setState(() {
      _available = canCheck;
    });
  }

  Future<void> _authenticate() async {
    final success = await _service.authenticate();
    setState(() {
      _enabled = success;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_available) {
      return Scaffold(
        appBar: AppBar(title: const Text('Biométrie')),
        body: const Center(child: Text('Biométrie non disponible')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Biométrie')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_enabled ? 'Activée' : 'Désactivée'),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text('Activer'),
            ),
          ],
        ),
      ),
    );
  }
}
