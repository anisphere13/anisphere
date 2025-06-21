import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/widgets/user_profile_summary_card.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/l10n/app_localizations.dart';

void main() {
  testWidgets('shows update button when data missing', (tester) async {
    final user = UserModel(
      id: '1',
      name: 'test',
      email: 'e',
      phone: '',
      profilePicture: '',
      profession: '',
      ownedSpecies: {},
      ownedAnimals: [],
      preferences: {},
      moduleRoles: {},
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
      activeModules: [],
      role: 'user',
      iaPremium: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: const Locale('fr'),
        home: Scaffold(
          body: UserProfileSummaryCard(user: user, proValidated: false),
        ),
      ),
    );
    final context = tester.element(find.byType(UserProfileSummaryCard));
    final label = AppLocalizations.of(context)!.profile_update_button;
    expect(find.text(label), findsOneWidget);
  });
}
