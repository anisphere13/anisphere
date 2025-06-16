library;

import 'dart:async';
import 'package:flutter/foundation.dart';

import '../logic/ia_logger.dart';
import '../logic/ia_channel.dart';
import '../models/payment_plan.dart';
import 'stripe_checkout_service.dart';
import 'local_storage_service.dart';

/// États possibles d'un achat in-app.
enum PurchaseState { initial, purchased, expired, cancelled }

/// Gère la mise à jour du statut d'achat et journalise les changements.
class PaymentService {
  final StripeCheckoutService _stripeService;
  PurchaseState _state = PurchaseState.initial;
  final List<String> _subscriptions = [];
  final StreamController<List<String>> _controller =
      StreamController<List<String>>.broadcast();

  PaymentService({StripeCheckoutService? stripeService})
      : _stripeService = stripeService ?? const StripeCheckoutService();

  PurchaseState get state => _state;

  /// Flux des mises à jour des abonnements actifs.
  Stream<List<String>> get subscriptionUpdates => _controller.stream;

  /// Renvoie la liste courante des abonnements actifs.
  Future<List<String>> getActiveSubscriptions() async {
    final stored =
        LocalStorageService.get('subscriptions', defaultValue: <String>[]);
    _subscriptions
      ..clear()
      ..addAll(stored is List ? stored.cast<String>() : <String>[]);
    return List.unmodifiable(_subscriptions);
  }

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

  /// Indique si le package `in_app_purchase` peut être utilisé sur la plateforme
  /// courante.
  @visibleForTesting
  bool get isIapSupported => !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  /// Lance le flux d'achat pour [plan]. Si `in_app_purchase` n'est pas supporté
  /// (ex. Web), un écran de paiement Stripe s'ouvre dans une WebView.
  Future<void> purchaseItem(PaymentPlan plan) async {
    if (_controller.isClosed) {
      throw StateError('PaymentService is disposed');
    }

    if (isIapSupported) {
      // TODO: intégrer le flux réel via le package in_app_purchase
      await Future<void>.delayed(const Duration(milliseconds: 100));
    } else {
      await _stripeService.openCheckout(plan);
    }

    _subscriptions.add(plan.id);
    _controller.add(List.unmodifiable(_subscriptions));
    await updateState(PurchaseState.purchased);
  }

  /// Libère les ressources détenues par le service.
  void dispose() {
    _controller.close();
  }
}
