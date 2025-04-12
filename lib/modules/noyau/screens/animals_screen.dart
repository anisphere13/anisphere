import 'package:flutter/material.dart';

/// Écran principal des animaux dans AniSphère.
class AnimalsScreen extends StatelessWidget {
  final Widget child;

  const AnimalsScreen({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: child),
    );
  }
}
