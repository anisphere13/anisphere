// Copilot Prompt : Écran de visualisation temps réel ou historique des scores IA, contextes, alertes comportementales ou recommandations

import 'package:flutter/material.dart';
import '../widgets/more_menu.dart';

class BehaviorDashboardScreen extends StatelessWidget {
  const BehaviorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de comportement'),
        actions: const [MoreMenuButton()],
      ),
      body: const Center(
        child: Text('Dashboard comportemental à venir'),
      ),
    );
  }
}

