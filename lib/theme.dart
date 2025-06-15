import 'package:flutter/material.dart';

final Color primaryBlue = const Color(0xFF183153);
final Color backgroundWhite = Colors.white;

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: backgroundWhite,
  primaryColor: primaryBlue,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryBlue,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  splashColor: Colors.transparent, // 👈 empêche les halos jaunes
  highlightColor: Colors.transparent, // 👈 idem pour les clics longs
  splashFactory: NoSplash.splashFactory, // 👈 désactive complètement les effets
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: backgroundWhite,
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
