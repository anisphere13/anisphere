import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/identite/screens/identity_screen.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import 'package:anisphere/modules/identite/widgets/identity_score_widget.dart';

import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockBox extends Mock implements Box<IdentityModel> {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('IdentityScreen displays score and import button',
      (WidgetTester tester) async {
    final service = IdentityService(localBox: MockBox());
    final animal = AnimalModel(
      id: 'test',
      name: 'Test',
      species: 'dog',
      breed: 'beagle',
      imageUrl: 'https://example.com',
      ownerId: 'owner',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await tester.pumpWidget(MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('fr'),
      home: IdentityScreen(animals: [animal], service: service),
    ));

    await tester.pump(); // allow future to resolve
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(IdentityScoreWidget), findsOneWidget);
    expect(find.text('Import I-CAD express'), findsOneWidget);
  });
}
