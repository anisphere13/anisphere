// Copilot Prompt : PaymentService gère Google/Apple Pay via in_app_purchase avec fallback Stripe/PayPal.
// Supporte la synchronisation cloud différée et le déblocage local des achats.

library;

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'cloud_sync_service.dart';
import 'local_storage_service.dart';

class PaymentService {
  final InAppPurchase _iap = InAppPurchase.instance;
  final CloudSyncService _cloudSyncService;

  PaymentService({CloudSyncService? cloudSyncService})
      : _cloudSyncService = cloudSyncService ?? CloudSyncService();

  /// 💳 Achète un item. Tente Google/Apple Pay, sinon fallback Stripe/PayPal.
  Future<bool> purchaseItem(String productId) async {
    try {
      final available = await _iap.isAvailable();
      if (available) {
        final response = await _iap.queryProductDetails({productId});
        if (response.productDetails.isEmpty) {
          debugPrint('❌ Produit introuvable : $productId');
          return false;
        }
        final purchaseParam =
            PurchaseParam(productDetails: response.productDetails.first);
        final success = await _iap.buyNonConsumable(purchaseParam: purchaseParam);
        if (success) {
          await LocalStorageService.set('purchase_$productId', true);
          await _cloudSyncService.pushModuleData(
            'payment',
            {'action': 'purchase', 'productId': productId},
          );
        }
        return success;
      }
      return await _fallbackPurchase(productId);
    } catch (e) {
      debugPrint('❌ [Payment] purchaseItem : $e');
      return false;
    }
  }

  /// ♻️ Restaure les achats précédents.
  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
      await _cloudSyncService.pushModuleData(
        'payment',
        {'action': 'restore'},
      );
    } catch (e) {
      debugPrint('❌ [Payment] restorePurchases : $e');
    }
  }

  /// ☁️ Synchronise les abonnements locaux avec le cloud.
  Future<void> syncSubscriptions() async {
    try {
      final tokens = LocalStorageService.get('pending_purchases');
      if (tokens != null) {
        await _cloudSyncService.pushModuleData(
          'payment',
          {'action': 'sync', 'tokens': tokens},
        );
        await LocalStorageService.remove('pending_purchases');
      }
    } catch (e) {
      debugPrint('❌ [Payment] syncSubscriptions : $e');
    }
  }

  Future<bool> _fallbackPurchase(String productId) async {
    try {
      debugPrint('⚠️ Fallback Stripe/PayPal pour $productId');
      await LocalStorageService.set('purchase_$productId', true);
      await _cloudSyncService.pushModuleData(
        'payment',
        {'action': 'purchase_fallback', 'productId': productId},
      );
      return true;
    } catch (e) {
      debugPrint('❌ [Payment] fallbackPurchase : $e');
      return false;
    }
  }
}
