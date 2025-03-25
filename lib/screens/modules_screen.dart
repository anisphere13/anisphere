import 'package:flutter/material.dart';

class ModulesScreen extends StatelessWidget {
  const ModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modules")),
      body: const Center(
        child: Text("Gestion des modules AniSphère"),
      ),
    );
  }
}

