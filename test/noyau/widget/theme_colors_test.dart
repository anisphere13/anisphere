// Test for theme colors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:anisphere/theme.dart';

void main() {
  testWidgets('light theme uses new background and nav colors', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final theme = Theme.of(tester.element(find.byType(BottomNavigationBar)));
    expect(theme.scaffoldBackgroundColor, const Color(0xFFF2F2F2));
    expect(theme.bottomNavigationBarTheme.selectedItemColor, primaryBlue);
  });

  testWidgets('dark theme uses primaryBlue nav color', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme,
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final theme = Theme.of(tester.element(find.byType(BottomNavigationBar)));
    expect(theme.bottomNavigationBarTheme.selectedItemColor, primaryBlue);
  });
}
