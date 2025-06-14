library;

import 'package:flutter/material.dart';

class LegalScreen extends StatelessWidget {
  final String consentType;
  const LegalScreen({super.key, required this.consentType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consentement')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text('Conditions pour $consentType...'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("J'accepte"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Refuser'),
            ),
          ],
        ),
      ),
    );
  }
}
