// Copilot Prompt : PaymentService stub for AniSphère.
// Provides subscription updates for premium features.
library;

import 'dart:async';

/// Simple in-memory payment service for tests.
class PaymentService {
  final StreamController<List<String>> _controller =
      StreamController<List<String>>.broadcast();
  List<String> _subscriptions = [];

  /// Stream of active subscription identifiers.
  Stream<List<String>> get subscriptionUpdates => _controller.stream;

  /// Current active subscriptions.
  Future<List<String>> getActiveSubscriptions() async => _subscriptions;

  /// Updates the active subscriptions and notifies listeners.
  void updateSubscriptions(List<String> subs) {
    _subscriptions = List.unmodifiable(subs);
    _controller.add(_subscriptions);
  }

  /// Dispose the internal controller.
  void dispose() {
    _controller.close();
  }
}
