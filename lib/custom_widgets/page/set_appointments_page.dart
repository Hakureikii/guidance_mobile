import 'package:flutter/material.dart';
import '../../services/auth/logout_users.dart';

class SetAppointmentsPage extends StatefulWidget {
  const SetAppointmentsPage({super.key});

  @override
  State<SetAppointmentsPage> createState() => _SetAppointmentsPageState();
}

class _SetAppointmentsPageState extends State<SetAppointmentsPage> {
  void logout() async {
    final user = await LogoutUsers.logout();

    if (user == 'session_clear') {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Header
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          color: Color(0xFF048c6c),
          child: Row(
            children: [
              // Space
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/studentDashboard',
                    );
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),

              // Title
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Appointments',
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
                  'Set Appointments',
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
                  backgroundColor: WidgetStatePropertyAll(Colors.black.withAlpha(20)),
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
                tooltip: 'Profile',
                icon: Icon(Icons.person_2),
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
    );
  }
}
