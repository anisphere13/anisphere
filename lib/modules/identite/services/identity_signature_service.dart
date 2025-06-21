import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../models/identity_model.dart';

/// Offline service signing identity data using HMAC-SHA256.
class IdentitySignatureService {
  final List<int> _key;

  IdentitySignatureService(String secret) : _key = utf8.encode(secret);

  /// Generates a signature string for the given identity model.
  String sign(IdentityModel model) {
    final hmac = Hmac(sha256, _key);
    final data = utf8.encode(model.toMap().toString());
    return hmac.convert(data).toString();
  }

  /// Verifies that [signature] matches the provided [model].
  bool verify(IdentityModel model, String signature) {
    final expected = sign(model);
    return _constantTimeEquals(expected, signature);
  }

  bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}
