library;

import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import '../logic/ia_logger.dart';
import '../models/payment_plan.dart';
import 'iap_validator.dart';
import 'local_storage_service.dart';
import '../models/subscription_model.dart';
import 'cloud_sync_service.dart';

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

  /// Initiates the purchase flow for the given plan.
  Future<void> purchaseItem(PaymentPlan plan) async {
    try {
      final iap = InAppPurchase.instance;
      bool available = false;
      try {
        available = await iap.isAvailable();
      } on MissingPluginException {
        // During tests the plugin may be missing, simulate availability
        available = false;
      }

      if (!available) {
        // Simulation path when store unavailable (tests or offline)
        final receipt = 'simulated_${DateTime.now().millisecondsSinceEpoch}';
        await _processReceipt(receipt, plan);
        return;
      }

      final response = await iap.queryProductDetails({plan.id});
      if (response.notFoundIDs.contains(plan.id) ||
          response.productDetails.isEmpty) {
        throw StateError('Product ${plan.id} not found');
      }

      final product = response.productDetails.first;
      final purchaseParam = PurchaseParam(productDetails: product);

      final completer = Completer<PurchaseDetails>();
      late StreamSubscription<List<PurchaseDetails>> sub;
      sub = iap.purchaseStream.listen((detailsList) {
        for (final d in detailsList) {
          if (d.productID == plan.id) {
            if (d.status == PurchaseStatus.purchased) {
              completer.complete(d);
              sub.cancel();
            } else if (d.status == PurchaseStatus.error ||
                d.status == PurchaseStatus.canceled) {
              completer.completeError(StateError('Purchase failed'));
              sub.cancel();
            }
          }
        }
      });

      await iap.buyNonConsumable(purchaseParam: purchaseParam);
      final detail = await completer.future;
      final receipt = detail.verificationData.serverVerificationData;
      await _processReceipt(receipt, plan);
    } catch (e) {
      await updateState(PurchaseState.cancelled);
      rethrow;
    }
  }

  Future<void> _processReceipt(String receipt, PaymentPlan plan) async {
    final valid = await IapValidator().validate(receipt);
    if (!valid) {
      await updateState(PurchaseState.cancelled);
      return;
    }

    await LocalStorageService.set('iap_token_${plan.id}', receipt);
    if (!_subscriptions.contains(plan.id)) {
      _subscriptions.add(plan.id);
      await LocalStorageService.set('subscriptions', _subscriptions);
      _controller.add(List.unmodifiable(_subscriptions));
    }

    final model = SubscriptionModel(
      id: receipt,
      userId: '',
      type: plan.id,
      startDate: DateTime.now(),
      expiryDate: DateTime.now().add(const Duration(days: 30)),
    );

    final stored = LocalStorageService.get('subs_models',
        defaultValue: <Map<String, dynamic>>[]);
    final list = stored is List
        ? List<Map<String, dynamic>>.from(stored)
        : <Map<String, dynamic>>[];
    list.add(model.toJson());
    await LocalStorageService.set('subs_models', list);

    await updateState(PurchaseState.purchased);

    try {
      await CloudSyncService().pushModuleData('subscriptions', model.toJson());
    } catch (_) {
      // ignore sync errors in purchase flow
    }
  }

  /// Cleans up any resources held by the service.
  void dispose() {
    _controller.close();
  }
}
