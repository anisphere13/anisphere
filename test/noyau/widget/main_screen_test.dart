// Copilot Prompt : Test automatique généré pour main_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/providers/ia_context_provider.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/screens/main_screen.dart';
import 'package:anisphere/main.dart';
import 'package:anisphere/modules/noyau/screens/splash_screen.dart';
import 'package:anisphere/modules/noyau/i18n/i18n_provider.dart';
import 'package:anisphere/modules/noyau/providers/theme_provider.dart';

import '../../test_config.dart';

class _TestUserProvider extends UserProvider {
  _TestUserProvider() : super(UserService(skipHiveInit: true), AuthService());
}

class _NullUserProvider extends UserProvider {
  _NullUserProvider() : super(UserService(skipHiveInit: true), AuthService());

  @override
  Future<void> loadUser() async {
    // Intentionally do nothing to keep user null
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('AppBar uses custom style', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(create: (_) => _TestUserProvider()),
          ChangeNotifierProvider<IAContextProvider>(create: (_) => IAContextProvider()),
        ],
        child: const MaterialApp(home: MainScreen()),
      ),
    );

    await tester.pumpAndSettle();

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor, const Color(0xFFF5F5F5));
    expect(appBar.foregroundColor, const Color(0xFF183153));
    expect(appBar.elevation, 0);

    final title = tester.widget<Text>(find.text('AniSphère'));
    expect(title.style?.fontWeight, FontWeight.w600);
    expect(title.style?.fontSize, 20);
    expect(title.style?.color, const Color(0xFF183153));

    final qrIcon = tester.widget<Icon>(find.widgetWithIcon(IconButton, Icons.qr_code));
    expect(qrIcon.color, const Color(0xFF183153));

    final menuIcon = tester.widget<Icon>(find.widgetWithIcon(PopupMenuButton<String>, Icons.more_vert));
    expect(menuIcon.color, const Color(0xFF183153));
  });

  testWidgets('shows SplashScreen when user is null', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(create: (_) => _NullUserProvider()),
          ChangeNotifierProvider<I18nProvider>(create: (_) => I18nProvider()),
          ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(MainScreen), findsNothing);
  });
}

