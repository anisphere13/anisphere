
import 'package:flutter/material.dart';

/// Provides global navigation without requiring a BuildContext.
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Pushes the given widget onto the navigation stack if possible.
  static Future<void> push(Widget page) async {
    final state = navigatorKey.currentState;
    if (state != null) {
      await state.push(MaterialPageRoute(builder: (_) => page));
    }
  }

  /// Returns the global navigation context if available.
  static BuildContext? get context => navigatorKey.currentContext;
}
