/// Copilot Prompt : Widget NotificationIcon pour AniSphère.
/// Affiche une cloche avec un badge rouge si des notifications non lues sont présentes.
/// S'intègre dans l'AppBar de `MainScreen`.

library;

import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onTap;

  const NotificationIcon({
    super.key,
    required this.unreadCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: onTap,
        ),
        if (unreadCount > 0)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
