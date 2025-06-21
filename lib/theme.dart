import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF183153);
const Color backgroundGray = Color(0xFFF2F2F2); // ✅ gris clair Samsung Health

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: backgroundGray, // ✅ fond global de tous les écrans
  cardColor: Colors.white, // ✅ toutes les Card par défaut
  primaryColor: primaryBlue,
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundGray,
    foregroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  splashFactory: NoSplash.splashFactory,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: backgroundGray,
    selectedItemColor: primaryBlue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
  iconTheme: const IconThemeData(color: primaryBlue),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryBlue,
    secondary: primaryBlue,
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryBlue,
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundGray,
    foregroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: primaryBlue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
  ),
  colorScheme: const ColorScheme.dark(
    primary: primaryBlue,
    secondary: primaryBlue,
  ),
);
