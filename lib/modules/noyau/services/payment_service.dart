library;

import 'dart:async';

import '../logic/ia_logger.dart';
import '../models/payment_plan.dart';

/// États possibles d'un achat in-app.
enum PurchaseState { initial, purchased, expired, cancelled }

/// Gère la mise à jour du statut d'achat et journalise les changements.
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

  /// Achète [plan] et notifie les abonnements actifs.
  Future<void> purchaseItem(PaymentPlan plan) async {
    await updateState(PurchaseState.purchased);
    if (!_subscriptions.contains(plan.id)) {
      _subscriptions.add(plan.id);
      if (!_controller.isClosed) {
        _controller.add(List.unmodifiable(_subscriptions));
      }
    }
  }

  /// Ferme le flux interne.
  void dispose() {
    _controller.close();
  }
}
