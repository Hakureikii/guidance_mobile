
import 'package:flutter/material.dart';
import 'package:guidance/services/notifications/notifications.dart';

class NotificationBadge extends StatefulWidget {
  const NotificationBadge({super.key});

  @override
  State<NotificationBadge> createState() =>
      _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    loadUnreadNotifications();
  }

  Future<void> loadUnreadNotifications() async {
    final result = await Notifications.studentNotifications();

    if (result is List) {
      final count = result
          .where((notification) => notification['is_read'] == false)
          .length;

      if (mounted) {
        setState(() {
          unreadCount = count;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.notifications_outlined),

        if (unreadCount >= 1)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount > 99 ? '99+' : '$unreadCount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
