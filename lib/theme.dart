import 'package:flutter/material.dart';
// TODO: ajouter test

const Color primaryBlue = Color(0xFF183153);
const Color backgroundGray = Color(0xFFF5F5F5); // ✅ gris clair Samsung Health

const Color accentYellow = Color(0xFFFBC02D);

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
  splashColor: accentYellow,
  highlightColor: accentYellow,
  splashFactory: NoSplash.splashFactory,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: backgroundGray,
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

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryBlue,
  splashColor: accentYellow,
  highlightColor: accentYellow,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF183153),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: accentYellow,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
  colorScheme: const ColorScheme.dark(
    primary: primaryBlue,
    secondary: primaryBlue,
  ),
);
