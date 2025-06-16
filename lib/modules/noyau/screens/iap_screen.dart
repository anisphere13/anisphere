// Screen listing available in-app purchase plans and allowing users to purchase one.
// Reuses the existing PaymentProvider.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/payment_provider.dart';
import '../models/payment_plan.dart';

class IapScreen extends StatelessWidget {
  const IapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentProvider provider = Provider.of<PaymentProvider>(context);
    final List<PaymentPlan> plans = provider.plans;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passer Premium'),
      ),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final PaymentPlan plan = plans[index];
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
