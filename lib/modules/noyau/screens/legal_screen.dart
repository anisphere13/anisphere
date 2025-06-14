library;

import 'package:flutter/material.dart';
import '../services/cgu_manager.dart';

/// Écran affichant les CGU et la politique de confidentialité.
/// Simple placeholder pour acceptation des versions actuelles.
class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CGU & Confidentialité')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await CguManager().acceptCurrent();
            Navigator.of(context).pop();
          },
          child: const Text("J'accepte"),
        ),
      ),
    );
  }
}
