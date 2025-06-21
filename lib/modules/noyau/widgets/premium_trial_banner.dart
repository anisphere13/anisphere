/// 📦 AniSphère – Essai Premium IA déclenché automatiquement
/// Vérifie si l’utilisateur gratuit est suffisamment actif.
/// Si l’IA locale connaît bien l’animal, propose un test gratuit de l’IA cloud.
/// 1 essai maximum. IA cloud activée automatiquement puis désactivée.
/// Rentabilisation progressive avec forte valeur perçue.
library;

import 'package:flutter/material.dart';

class PremiumTrialBanner extends StatelessWidget {
  final VoidCallback onActivate;

  const PremiumTrialBanner({super.key, required this.onActivate});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8E1),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Votre chien est maintenant reconnu par AniSphère. Testez gratuitement l’IA complète.',
              style: TextStyle(color: Color(0xFF183153)),
            ),
          ),
          TextButton(
            onPressed: onActivate,
            child: const Text('Activer l’essai gratuit'),
          ),
        ],
      ),
    );
  }
}
