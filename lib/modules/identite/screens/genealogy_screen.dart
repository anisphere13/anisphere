import 'package:flutter/material.dart';

class GenealogyScreen extends StatelessWidget {
  const GenealogyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Genealogy')),
      body: const Center(child: Text('Genealogy Screen')),
    );
  }
}
