library;

import 'package:flutter/foundation.dart';
import '../models/payment_plan.dart';
import '../services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _service;
  final List<PaymentPlan> _plans = const [
    PaymentPlan(
      id: 'premium',
      name: 'Premium Individuel',
      price: 3.99,
      description:
          'Fonctionnalités cloud, exports stylisés, IA renforcée',
    ),
    PaymentPlan(
      id: 'pro',
      name: 'Pro / Éducateur',
      price: 9.99,
      description: 'Interface multi-profils, IA éducative avancée',
    ),
  ];

  PaymentProvider({PaymentService? service})
      : _service = service ?? PaymentService();

  List<PaymentPlan> get plans => List.unmodifiable(_plans);

  Future<void> purchase(PaymentPlan plan) async {
    await _service.purchaseItem(plan);
  }
}
