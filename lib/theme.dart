import 'package:flutter/material.dart';

/// Application-wide theme settings.
final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF183153),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF183153),
    primary: const Color(0xFF183153),
    secondary: const Color(0xFFFBC02D),
  ),
  useMaterial3: true,
  highlightColor: const Color(0xFFFBC02D),
  splashColor: const Color(0xFFFBC02D),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF183153),
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color(0xFF3A3A3A)),
  ),
);
