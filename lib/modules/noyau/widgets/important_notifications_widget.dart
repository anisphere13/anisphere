import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../screens/notifications_screen.dart';

/// Display up to three important notifications.
/// Tapping the widget navigates to [NotificationsScreen].
class ImportantNotificationsWidget extends StatelessWidget {
  final List<String> notifications;

  const ImportantNotificationsWidget({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) return const SizedBox.shrink();

    final items = notifications.take(3).toList();

    return Card(
      margin: const EdgeInsets.all(16),
      color: backgroundGray,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notifications importantes',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              for (final n in items)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '• $n',
                    style: const TextStyle(color: primaryBlue),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
