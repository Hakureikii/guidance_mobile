import 'package:flutter/material.dart';
import 'package:guidance/services/auth/logout_users.dart';
import 'package:guidance/services/auth/sessions.dart';

class GuardianDashboardScreen extends StatefulWidget {
  const GuardianDashboardScreen({super.key});

  @override
  State<GuardianDashboardScreen> createState() =>
      _GuardianDashboardScreenState();
}

class _GuardianDashboardScreenState extends State<GuardianDashboardScreen> {
  String? greetings;

  void logout() async {
    final user = await LogoutUsers.logout();

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

    if (user == 'session_clear') {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  void session() async {
    final username = await Sessions.username();

    setState(() {
      greetings = 'Welcome $username';
    });
  }

  void screenAccess() async {
    final session = await Sessions.validate();
    if (session == 'no session') {
      Navigator.pushReplacementNamed(context, '/loginPage');
      return;
    }

    if (session == 'Guardian') {
      return;
    } else {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
    ;
  }

  @override
  void initState() {
    super.initState();
    session();
    screenAccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Container
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            color: Color(0xFF048c6c),
            child: Row(
              children: [
                // Space
                Container(width: MediaQuery.of(context).size.width * 0.2),

                // Title
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Archivo_black',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                // Logout button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: IconButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.white,
                    icon: Icon(Icons.logout),
                    onPressed: logout,
                  ),
                ),
              ],
            ),
          ),

          // Body Container
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Text(
                    '$greetings',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer Container
          Container(
            color: Color(0xFF048c6c),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.11,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.white,
                  tooltip: 'Refer Individuals',
                  icon: Icon(Icons.group),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),

                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.white,
                  tooltip: 'Add Appointment',
                  icon: Icon(Icons.document_scanner),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/setAppointments');
                  },
                ),

                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.white,
                  tooltip: 'Monitor Children',
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),

                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.white,
                  tooltip: 'Notifications',
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
