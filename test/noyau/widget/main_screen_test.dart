// Copilot Prompt : Test automatique généré pour main_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/providers/ia_context_provider.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/screens/main_screen.dart';
import 'package:anisphere/modules/noyau/screens/splash_screen.dart';
import 'package:anisphere/main.dart';
import 'package:anisphere/modules/noyau/providers/theme_provider.dart';
import 'package:anisphere/theme.dart';
import 'package:anisphere/modules/noyau/widgets/more_menu.dart';

import '../../test_config.dart';

class _TestUserProvider extends UserProvider {
  _TestUserProvider() : super(UserService(skipHiveInit: true), AuthService());
}

class _NullUserProvider extends UserProvider {
  _NullUserProvider() : super(UserService(skipHiveInit: true), AuthService());

  @override
  Future<void> loadUser() async {}
}


class _FakeThemeProvider with ChangeNotifier implements ThemeProvider {
  bool _isDarkMode = false;

  @override
  bool get isDarkMode => _isDarkMode;

  @override
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  @override
  Future<void> load() async {}

  @override
  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();
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
          ChangeNotifierProvider<UserProvider>(
            create: (_) => _TestUserProvider(),
          ),
          ChangeNotifierProvider<IAContextProvider>(
            create: (_) => IAContextProvider(),
          ),
        ],
        child: const MaterialApp(
          home: MainScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor, backgroundGray);
    expect(appBar.foregroundColor, primaryBlue);
    expect(appBar.elevation, 0);

    final title = tester.widget<Text>(find.text('Maison'));
    expect(title.style?.fontWeight, FontWeight.w600);
    expect(title.style?.fontSize, 20);
    expect(title.style?.color, primaryBlue);

    final qrIcon = tester.widget<Icon>(
      find.widgetWithIcon(IconButton, Icons.qr_code),
    );
    expect(qrIcon.color, primaryBlue);

    expect(find.byType(MoreMenuButton), findsOneWidget);
  });

  testWidgets('shows SplashScreen when user is null', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => _FakeThemeProvider(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (_) => _NullUserProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pump();

    expect(find.byType(MainScreen), findsNothing);
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
