library;

import 'package:flutter/material.dart';

import '../services/biometric_auth_service.dart';

class BiometricGuard extends StatefulWidget {
  final Widget child;
  const BiometricGuard({super.key, required this.child});

  @override
  State<BiometricGuard> createState() => _BiometricGuardState();
}

class _BiometricGuardState extends State<BiometricGuard> {
  final _service = BiometricAuthService();
  bool? _authorized;

  @override
  void initState() {
    super.initState();
    _verify();
  }

  Future<void> _verify() async {
    final ok = await _service.authenticateOrPin('Authentification requise');
    if (mounted) setState(() => _authorized = ok);
  }

  @override
  Widget build(BuildContext context) {
    if (_authorized == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_authorized!) {
      return widget.child;
    }
    return const Center(child: Text('Accès refusé'));
  }
}
