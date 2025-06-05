// 📄 test/noyau/integration/app_initializer_test.dart
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

import 'package:anisphere/main.dart';
import 'package:anisphere/modules/noyau/screens/splash_screen.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('App launches to SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(SplashScreen), findsOneWidget);
  });
}