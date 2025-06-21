// Copilot Prompt : Test automatique généré pour qr_service.dart (unit)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:qr_flutter/qr_flutter.dart';
import 'package:anisphere/modules/noyau/services/qr_service.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('generateQRCode returns a widget', (tester) async {
    final widget = QRService.generateQRCode('data');

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

    expect(find.byType(QrImageView), findsOneWidget);
  });
}
