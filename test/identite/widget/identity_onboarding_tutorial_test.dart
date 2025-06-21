import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/widgets/identity_onboarding_tutorial.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('IdentityOnboardingTutorial goes through steps', (tester) async {
    var finished = false;
    await tester.pumpWidget(MaterialApp(
      home: IdentityOnboardingTutorial(onFinish: () => finished = true),
    ));

    expect(find.text('Next'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pump();

    await tester.tap(find.text('Done'));
    await tester.pump();

    expect(finished, isTrue);
  });
}
