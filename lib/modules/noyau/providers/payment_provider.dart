library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import '../models/payment_plan.dart';
import '../services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _service;
  late final StreamSubscription<List<String>> _subscriptionSub;
  List<String> _subscriptions = const [];
  bool _isPremium = false;
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

  /// Returns `true` if the user currently has an active premium subscription.
  bool get isPremium => _isPremium;

  /// Active subscription identifiers for the current user.
  List<String> get subscriptions => List.unmodifiable(_subscriptions);

  /// Initializes the provider by loading current subscriptions and
  /// listening to updates from [PaymentService].
  Future<void> init() async {
    _subscriptions = await _service.getActiveSubscriptions();
    _isPremium = _subscriptions.contains('premium');
    notifyListeners();
    _subscriptionSub = _service.subscriptionUpdates.listen((subs) {
      _subscriptions = subs;
      _isPremium = _subscriptions.contains('premium');
      notifyListeners();
    });
  }

  Future<void> purchase(PaymentPlan plan) async {
    await _service.purchaseItem(plan);
  }

  @override
  void dispose() {
    _subscriptionSub.cancel();
    _service.dispose();
    super.dispose();
  }
}
