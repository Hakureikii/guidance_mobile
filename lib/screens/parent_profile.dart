import 'package:flutter/material.dart';
import '../widgets/app_navigation.dart';
import '../services/auth/sessions.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({super.key});

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  String role = '';

  int nav = 3;

  void setRole() async {
    final session = await Sessions.validate();
    setState(() {
      role = session;
    });
  }

  @override
  void initState() {
    super.initState();
    setRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation.appBar(
        context: context,
        title: 'Profile',
        role: role,
      ),
      body: Center(child: Text('Parent Profile Page')),

      bottomNavigationBar: AppNavigation.bottomNavigationBar(
        context: context,
        role: role,
        currentIndex: nav,
        onIndexChanged: (index) {
          setState(() {
            nav = index;
          });

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
            ); // Profile
            return;
          }
        },
      ),
    );
  }
}
