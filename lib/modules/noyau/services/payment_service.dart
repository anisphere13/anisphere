library;

import '../logic/ia_logger.dart';
import '../models/payment_plan.dart';

/// États possibles d'un achat in-app.
enum PurchaseState { initial, purchased, expired, cancelled }

/// Gère la mise à jour du statut d'achat et journalise les changements.
class PaymentService {
  PurchaseState _state = PurchaseState.initial;

  PurchaseState get state => _state;

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

  /// Stream emitting active subscription identifiers when they change.
  Stream<List<String>> get subscriptionUpdates => const Stream.empty();

  /// Returns the list of currently active subscription identifiers.
  Future<List<String>> getActiveSubscriptions() async => const [];

  /// Initiates the purchase flow for the given plan.
  Future<void> purchaseItem(PaymentPlan plan) async {}

  /// Cleans up any resources held by the service.
  void dispose() {}
}
