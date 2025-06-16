// Copilot Prompt : PaymentProvider pour AniSphère.
// Gère les abonnements et l\'état premium en écoutant PaymentService.

library;

import 'package:flutter/foundation.dart';
import '../services/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  final PaymentService _service;
  List<String> _subscriptions = [];
  bool _isPremium = false;
  late final StreamSubscription<List<String>> _sub;

  PaymentProvider({PaymentService? service})
      : _service = service ?? PaymentService();

  List<String> get subscriptions => List.unmodifiable(_subscriptions);
  bool get isPremium => _isPremium;

  Future<void> init() async {
    _subscriptions = await _service.getActiveSubscriptions();
    _isPremium = _subscriptions.isNotEmpty;
    _sub = _service.subscriptionUpdates.listen(_onUpdate);
    notifyListeners();
  }

  void _onUpdate(List<String> subs) {
    _subscriptions = subs;
    final newPremium = subs.isNotEmpty;
    if (newPremium != _isPremium) {
      _isPremium = newPremium;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _sub.cancel();
    _service.dispose();
    super.dispose();
  }
}
