/// Copilot Prompt : Widget IAChip pour AniSphère.
/// Affiche un petit badge (Chip) représentant un état IA ou un tag intelligent.
/// Utilisé dans les dashboards, listes d’animaux ou en haut des écrans IA.
import 'package:flutter/material.dart';

class IAChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? backgroundColor;

  const IAChip({
    super.key,
    required this.label,
    this.icon = Icons.memory,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: Icon(icon, size: 18),
      backgroundColor: backgroundColor ?? Colors.deepPurple.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.deepPurple.shade300),
      ),
    );
  }
}
