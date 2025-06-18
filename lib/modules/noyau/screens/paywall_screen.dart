// Deprecated screen kept for backward compatibility. Redirects to [IAPScreen].

import 'package:flutter/material.dart';

import 'iap_screen.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const IAPScreen();
  }
}
