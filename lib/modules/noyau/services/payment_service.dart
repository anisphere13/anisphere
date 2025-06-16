library;

import 'dart:async';

import '../logic/ia_logger.dart';
import '../models/payment_plan.dart';
import '../models/subscription_model.dart';
import 'local_storage_service.dart';

/// États possibles d'un achat in-app.
enum PurchaseState { initial, purchased, expired, cancelled }

/// Gère les achats in-app et la persistance des abonnements.
class PaymentService {
  PurchaseState _state = PurchaseState.initial;
  final List<String> _subscriptions = [];
  final StreamController<List<String>> _controller =
      StreamController<List<String>>.broadcast();

  PurchaseState get state => _state;

  /// Flux des mises à jour des abonnements actifs.
  Stream<List<String>> get subscriptionUpdates => _controller.stream;

  /// Renvoie la liste courante des abonnements actifs.
  Future<List<String>> getActiveSubscriptions() async =>
      List.unmodifiable(_subscriptions);

  Future<void> updateState(PurchaseState newState) async {
    _state = newState;
    switch (newState) {
      case PurchaseState.purchased:
        await IALogger.logIAPPurchased();
        break;
      case PurchaseState.expired:
        await IALogger.logIAPExpired();
        break;
      case PurchaseState.cancelled:
        await IALogger.logIAPCancelled();
        break;
      case PurchaseState.initial:
        break;
    }
  }

  /// Lance le processus d'achat pour le plan fourni.
  Future<void> purchaseItem(PaymentPlan plan) async {
    if (_controller.isClosed) {
      throw StateError('PaymentService disposed');
    }
    await updateState(PurchaseState.purchased);
    if (!_subscriptions.contains(plan.id)) {
      _subscriptions.add(plan.id);
    }
    _controller.add(List.unmodifiable(_subscriptions));

    final now = DateTime.now();
    final sub = SubscriptionModel(
      id: plan.id,
      userId: 'local',
      type: plan.id,
      startDate: now,
      expiryDate: now.add(const Duration(days: 30)),
      status: SubscriptionStatus.active,
    );
    await LocalStorageService.saveSubscription(sub);
  }

  /// Libère les ressources détenues par le service.
  void dispose() {
    _controller.close();
  }
}
