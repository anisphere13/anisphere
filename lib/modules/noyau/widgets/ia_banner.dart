// Copilot Prompt : Widget IABanner pour AniSphère.
// Affiche une bannière contextuelle IA en haut d’un écran.
// Peut signaler un état IA actif (mode onboarding, offline, alerte santé).
// Discret, mais visible et réutilisable dans tous les modules.
import 'package:flutter/material.dart';
import '../../../theme.dart';

class IABanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color background;
  final Color textColor;

  const IABanner({
    super.key,
    required this.message,
    this.icon = Icons.info_outline,
    this.background = backgroundGray,
    this.textColor = const Color(0xFF183153),  // Bleu nuit
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFD6D6D6)), // Gris doux
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
