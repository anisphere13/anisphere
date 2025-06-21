
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/anisphere_app_bar.dart';

import '../models/payment_plan.dart';
import 'navigation_service.dart';

/// Service minimal ouvrant la page Stripe Checkout dans une WebView.
/// Utilisé comme solution de repli lorsque `in_app_purchase` n'est pas disponible.
class StripeCheckoutService {
  const StripeCheckoutService();

  Future<void> openCheckout(PaymentPlan plan) async {
    final url = 'https://example.com/checkout/${plan.id}';
    await NavigationService.push(_StripeCheckoutPage(url: url));
  }
}

class _StripeCheckoutPage extends StatelessWidget {
  final String url;
  const _StripeCheckoutPage({required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: const AniSphereAppBar(title: 'Paiement sécurisé'),
      body: WebViewWidget(controller: controller),
    );
  }
}
