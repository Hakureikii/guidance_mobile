import 'package:flutter/material.dart';
import '../../services/auth/logout_users.dart';
import '../services/sessions/student_sessions.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SessionScreen()));
}

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
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
            children: [Text('Are you sure you want to logout?')],
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
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  Future<dynamic> studentSessionRecord() async {
    final sessions = await StudentSessions.sessions();
    debugPrint(sessions.toString());
  }

  @override
  void initState() {
    super.initState();
    studentSessionRecord();
    // session();
    // screenAccess();
    // checkNotifications();
    // newUser();
    // referralSent();
    // upcomingSessions();
  }

  int nav = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 55,
        backgroundColor: Color(0XFF048c6c),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.12),

            Text(
              'Sessions',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Archivo_black',
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
              child: IconButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(CircleBorder()),
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.white,
                icon: Icon(Icons.logout, size: 20),
                onPressed: logoutModal,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomNavigationBar(
          backgroundColor: Color(0xFF048c6c),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          currentIndex: nav,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white, // optional, overridden by selectedItemColor
          ),
          onTap: (index) {
            setState(() {
              nav = index;
            });

            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/'); // Home
              return;
            }

            if (index == 1) {
              Navigator.pushReplacementNamed(
                context,
                '/referStudents',
              ); // Refer
              return;
            }

            if (index == 2) {
              Navigator.pushReplacementNamed(context, '/'); // Session
              return;
            }

            if (index == 3) {
              Navigator.pushReplacementNamed(
                context,
                '/studentProfile',
              ); // Profile
              return;
            }

            if (index == 4) {
              Navigator.pushReplacementNamed(
                context,
                '/studentNotifications',
              ); // Notifications
              return;
            }
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              label: 'Refer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Session',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notif',
            ),
          ],
        ),
      ),
    );
  }
}
