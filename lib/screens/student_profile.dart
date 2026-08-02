import 'package:flutter/material.dart';
import 'package:guidance/services/auth/logout_users.dart';
import 'package:guidance/services/auth/sessions.dart';
import 'package:guidance/database/database_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String? firstname;
  String? lastname;
  String? studentId;
  String? email;
  String? course;
  String? role;
  int? userId;
  String? token;

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

  void setRole() async {
    final session = await Sessions.validate();
    setState(() {
      role = session;
    });
  }

  void screenAccess() async {
    final session = await Sessions.validate();
    if (session == 'no session') {
      Navigator.pushReplacementNamed(context, '/loginPage');
      return;
    }

    if (session == 'Student') {
      return;
    } else {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  void getCredentials() async {
    final session = await SharedPreferences.getInstance();
    final id = session.getInt('userId');
    final string = session.getString('token');

    final response = await DatabaseConfiguration.client
        .from('student_tb')
        .select("first_name, last_name, student_number, email_address, course")
        .eq('student_id', id.toString())
        .single();

    userId = id;
    token = string;
    setState(() {
      firstname = response['first_name'];
      lastname = response['last_name'];
      email = response['email_address'];
      studentId = response['student_number'];
      course = response['course'];
    });
  }

  void navigateBack() {
    if (role == 'Student') {
      Navigator.pushReplacementNamed(context, '/studentDashboard'); // Home
      return;
    }

    if (role == 'Parent') {
      Navigator.pushReplacementNamed(context, '/'); // Home
      return;
    }

    if (role == 'Guardian') {
      Navigator.pushReplacementNamed(context, '/'); // Home
      return;
    }

    if (role == 'Faculty') {
      Navigator.pushReplacementNamed(context, '/'); // Home
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    setRole();
    screenAccess();
    getCredentials();
  }

  int nav = 3;

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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
              child: IconButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(CircleBorder()),
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.white,
                icon: Icon(Icons.navigate_before, size: 20),
                onPressed: navigateBack,
              ),
            ),

            Text(
              'Profile',
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

      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              CircleAvatar(radius: 50.0, child: Icon(Icons.person_2, size: 30)),

              SizedBox(height: 10),
              Text(
                '$firstname $lastname',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),

              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0XFF048c6c),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  'Student',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    // Full Name
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.withAlpha(90),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Icon(
                              Icons.person_2_outlined,
                              color: Color(0xFF048c6c),
                            ),
                          ),

                          SizedBox(width: 8),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full Name',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '$firstname $lastname',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8),
                        ],
                      ),
                    ),

                    Divider(thickness: 1, height: 20),

                    // Student Number
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withAlpha(90),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Icon(
                              Icons.credit_card_outlined,
                              color: Color.fromARGB(255, 4, 20, 140),
                            ),
                          ),

                          SizedBox(width: 8),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student-ID',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '$studentId',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Divider(thickness: 1, height: 20),

                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0XFFFFF394).withAlpha(90),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Icon(
                              Icons.email_outlined,
                              color: Color.fromARGB(255, 123, 102, 0),
                            ),
                          ),

                          SizedBox(width: 8),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '$email',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, height: 20),

                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withAlpha(90),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Icon(
                              Icons.school_outlined,
                              color: Color.fromARGB(255, 4, 20, 140),
                            ),
                          ),

                          SizedBox(width: 8),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Course',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '$course',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8),
                  ],
                ),
              ),

              SizedBox(height: 10),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () {
                  final Uri url = Uri.parse(
                    'http://192.168.1.102/Research_Web/pdf/generate_pdf.html?student_id=$userId&token=$token',
                  );
                  launchUrl(url);
                },
                child: Text(
                  'Generate Individual Inventory',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                ),
              ),

              SizedBox(height: 8),
            ],
          ),
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
