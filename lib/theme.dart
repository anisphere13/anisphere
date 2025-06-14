import 'package:flutter/material.dart';

ThemeData buildAniSphereTheme() {
  const primaryColor = Color(0xFF183153);
  const highlightColor = Color(0xFFFBC02D);
  const lightGray = Color(0xFFF5F5F5);
  const darkGray = Color(0xFF3A3A3A);

  return ThemeData(
    scaffoldBackgroundColor: lightGray,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: highlightColor,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: darkGray),
    ),
  );
}
