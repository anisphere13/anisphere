// Copilot Prompt : Test automatique généré pour home_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/providers/ia_context_provider.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/screens/home_screen.dart';
import 'package:anisphere/modules/noyau/widgets/important_notifications_widget.dart';

import '../../test_config.dart';

class _TestUserProvider extends UserProvider {
  _TestUserProvider() : super(UserService(skipHiveInit: true), AuthService());
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('renders without AppBar and shows menu button', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (_) => _TestUserProvider()),
          ChangeNotifierProvider<IAContextProvider>(
              create: (_) => IAContextProvider()),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsNothing);
    expect(find.byIcon(Icons.more_vert), findsOneWidget);
  });

  testWidgets('displays important notifications widget', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (_) => _TestUserProvider()),
          ChangeNotifierProvider<IAContextProvider>(
              create: (_) => IAContextProvider()),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ImportantNotificationsWidget), findsOneWidget);
  });
}
