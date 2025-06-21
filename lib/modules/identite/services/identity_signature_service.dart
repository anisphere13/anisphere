import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// Simple service to append a digital signature to PDF data.
class IdentitySignatureService {
  /// Signs [pdfData] with a SHA-256 hash using [signerId].
  Uint8List signPdf(Uint8List pdfData, String signerId) {
    final digest = sha256.convert(<int>[...pdfData, ...utf8.encode(signerId)]);
    final signature = utf8.encode('\nSignedBy:$signerId:${digest.toString()}');
    return Uint8List.fromList([...pdfData, ...signature]);
  }
}
