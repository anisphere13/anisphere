import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/widgets/identity_score_widget.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('IdentityScoreWidget shows percentage and progress', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: IdentityScoreWidget(score: 75)));
    expect(find.textContaining('75'), findsOneWidget);
    final bar = tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
    expect(bar.value, 0.75);
  });
}
