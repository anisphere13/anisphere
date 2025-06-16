library;

import 'package:flutter/material.dart';

import 'paywall_screen.dart';

/// Wrapper around [PaywallScreen] to expose it as IAPScreen.
class IAPScreen extends StatelessWidget {
  const IAPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaywallScreen();
  }
}
