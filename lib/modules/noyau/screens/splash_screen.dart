import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF183153),
      body: Center(
        child: Image(image: AssetImage('assets/logo/anisphere_logo.png')),
      ),
    );
  }
}
