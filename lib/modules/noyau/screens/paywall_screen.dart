// Copilot Prompt : Écran Paywall/IAP pour AniSphère.
// Affiche les plans depuis PaymentProvider et achète via PaymentService.purchaseItem.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/payment_provider.dart';
import '../models/payment_plan.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentProvider>(context);
    final plans = provider.plans;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passer Premium'),
      ),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(plan.name),
              subtitle: Text('${plan.price.toStringAsFixed(2)} €/mois'),
              trailing: ElevatedButton(
                onPressed: () => provider.purchase(plan),
                child: const Text('Choisir'),
              ),
            ),
          );
        },
      ),
    );
  }
}
