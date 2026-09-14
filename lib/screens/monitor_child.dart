import 'package:flutter/material.dart';
import '../../services/auth/logout_users.dart';
import 'package:guidance/services/auth/sessions.dart';
import '../widgets/app_navigation.dart';

class MonitorChild extends StatefulWidget {
  const MonitorChild({super.key});

  @override
  State<MonitorChild> createState() => _MonitorChildState();
}

class _MonitorChildState extends State<MonitorChild> {
  String role = '';

  void logoutModal() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          title: Text('Logout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('Are you sure you want to log out?')],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('No'),
            ),
            TextButton(onPressed: logout, child: Text('Yes')),
          ],
        );
      },
    );
  }

  void logout() async {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          title: Text('Logging Out'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Please wait'),
            ],
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 2));

    final user = await LogoutUsers.logout();

    if (user == 'session_clear') {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  void navigateBack() {
    if (role == 'Student') {
      Navigator.pushReplacementNamed(context, '/studentDashboard'); // Home
      return;
    }

    if (role == 'Parent') {
      Navigator.pushReplacementNamed(context, '/parentDashboard'); // Home
      return;
    }

    if (role == 'Guardian') {
      Navigator.pushReplacementNamed(context, '/guardianDashboard'); // Home
      return;
    }

    if (role == 'Faculty') {
      Navigator.pushReplacementNamed(context, '/facultyDashboard'); // Home
      return;
    }
  }

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

  int nav = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation.appBar(
        context: context,
        title: 'Monitor Child',
        role: role,
      ),

      bottomNavigationBar: AppNavigation.bottomNavigationBar(
        context: context,
        role: role,
        currentIndex: nav,
        onIndexChanged: (index) {
          setState(() {
            nav = index;
          });

          if (index == 0) {
            navigateBack();
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
              role == 'Student'
                  ? '/studentProfile'
                  : role == 'Parent'
                  ? '/parentProfile'
                  : role == 'Guardian'
                  ? '/guardianProfile'
                  : '/facultyProfile',
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
