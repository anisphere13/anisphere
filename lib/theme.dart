import 'package:flutter/material.dart';

final Color primaryBlue = const Color(0xFF183153);
final Color backgroundGray = const Color(0xFFF5F5F5); // ✅ gris clair Samsung Health

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: backgroundGray, // ✅ fond global de tous les écrans
  cardColor: Colors.white, // ✅ toutes les Card par défaut
  primaryColor: primaryBlue,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryBlue,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  splashColor: Colors.transparent, // pas de halo jaune
  highlightColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: primaryBlue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
  iconTheme: IconThemeData(color: primaryBlue),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryBlue,
    secondary: primaryBlue,
  ),
);
