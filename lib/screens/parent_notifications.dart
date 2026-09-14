import 'package:flutter/material.dart';
import '../widgets/app_navigation.dart';

class ParentNotifications extends StatefulWidget {
  const ParentNotifications({super.key});

  @override
  State<ParentNotifications> createState() => _ParentNotificationsState();
}

class _ParentNotificationsState extends State<ParentNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation.appBar(
        context: context,
        title: 'Notifications',
        role: 'Parent',
      ),
      body: Center(child: Text('Parent Notifications Page')),

      bottomNavigationBar: AppNavigation.bottomNavigationBar(
        context: context,
        role: 'Parent',
        currentIndex: 4,
        onIndexChanged: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/parentDashboard'); // Home
            return;
          }

          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/referStudents'); // Refer
            return;
          }

          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/monitorChild'); // Session
            return;
          }

          if (index == 3) {
            Navigator.pushReplacementNamed(
              context,
              '/parentProfile',
            ); // Profile
            return;
          }

          if (index == 4) {
            Navigator.pushReplacementNamed(
              context,
              '/parentNotifications',
            ); // Notifications
            return;
          }
        },
      ),
    );
  }
}
