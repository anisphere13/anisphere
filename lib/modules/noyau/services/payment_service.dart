library;

import 'dart:async';
import 'package:flutter/foundation.dart';

import '../logic/ia_logger.dart';
import '../logic/ia_channel.dart';
import '../models/payment_plan.dart';
import 'iap_validator.dart';
import 'local_storage_service.dart';

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

  /// Démarre l'achat pour [plan].
  /// Un [receipt] peut être fourni pour validation.
  Future<void> purchaseItem(PaymentPlan plan, {String? receipt}) async {
    if (receipt != null) {
      final valid = await IapValidator().validate(receipt);
      if (!valid) {
        await IALogger.log(
          message: 'IAP_INVALID',
          channel: IAChannel.system,
        );
        await LocalStorageService.set('iap_locked', true);
        debugPrint('❌ Achat refusé pour ${plan.id}');
        return;
      }
    }

    await updateState(PurchaseState.purchased);
    if (!_subscriptions.contains(plan.id)) {
      _subscriptions.add(plan.id);
      _controller.add(List.unmodifiable(_subscriptions));
    } else {
      _controller.add(List.unmodifiable(_subscriptions));
    }
  }

  /// Libère les ressources détenues par le service.
  void dispose() {
    _controller.close();
  }
}
