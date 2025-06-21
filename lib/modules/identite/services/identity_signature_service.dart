import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'dart:typed_data';

/// Offline service for signing data using HMAC-SHA256.
class IdentitySignatureService {
  final List<int> _key;

  IdentitySignatureService(String secret) : _key = utf8.encode(secret);

  /// Generates a signature string for the provided [data].
  String sign(Uint8List data) {
    final hmac = Hmac(sha256, _key);
    return hmac.convert(data).toString();
  }

  /// Verifies that [signature] matches the given [data].
  bool verify(Uint8List data, String signature) {
    final expected = sign(data);
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
