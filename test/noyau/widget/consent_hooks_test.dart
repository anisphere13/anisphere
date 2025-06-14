import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/hooks/consent_hooks.dart';
import 'package:anisphere/modules/noyau/screens/legal_screen.dart';

class FakeConsentService extends ConsentService {
  bool has = false;
  bool saved = false;
  @override
  Future<bool> hasConsent(String type) async => has;
  @override
  Future<void> saveConsent(String type) async {
    saved = true;
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('shows LegalScreen when consent missing', (tester) async {
    final service = FakeConsentService();
    consentService = service;
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () => ensureConsent(context, 'test'),
          child: const Text('check'),
        ),
      ),
    ));
    await tester.tap(find.text('check'));
    await tester.pumpAndSettle();
    expect(find.byType(LegalScreen), findsOneWidget);
    await tester.tap(find.text("J'accepte"));
    await tester.pumpAndSettle();
    expect(service.saved, isTrue);
  });

  testWidgets('skips LegalScreen when consent already given', (tester) async {
    final service = FakeConsentService()..has = true;
    consentService = service;
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () => ensureConsent(context, 'test'),
          child: const Text('check'),
        ),
      ),
    ));
    await tester.tap(find.text('check'));
    await tester.pumpAndSettle();
    expect(find.byType(LegalScreen), findsNothing);
    expect(service.saved, isFalse);
  });
}
