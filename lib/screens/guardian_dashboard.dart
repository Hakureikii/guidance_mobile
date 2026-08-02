import 'package:flutter/material.dart';
import 'package:guidance/services/auth/logout_users.dart';
import 'package:guidance/services/auth/sessions.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: GuardianDashboard()),
  );
}

class GuardianDashboard extends StatefulWidget {
  const GuardianDashboard({super.key});

  @override
  State<GuardianDashboard> createState() => _GuardianDashboardState();
}

class _GuardianDashboardState extends State<GuardianDashboard> {
  String? user;

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

  void session() async {
    final username = await Sessions.username();
    print(username);

    setState(() {
      user = '$username';
    });
  }

  void screenAccess() async {
    final session = await Sessions.validate();

    print(session);
    if (session == 'no session') {
      Navigator.pushReplacementNamed(context, '/loginPage');
      return;
    }

    if (session == 'Guardian') {
      return;
    } else {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }

  }

  int nav = 0;

  @override
  void initState() {
    super.initState();
    session();
    // screenAccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 55,
        backgroundColor: Color(0XFF048c6c),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.12),

            Text(
              'Dashboard',
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

      // Bottom NavBar
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
              Navigator.pushReplacementNamed(context, '/'); // Profile
              return;
            }

            if (index == 4) {
              Navigator.pushReplacementNamed(context, '/'); // Notifications
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
              icon: Icon(Icons.child_care),
              label: 'Children',
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

      body: Center(
        child: Column(
          children: [
            // Body Container
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.93,
                      decoration: BoxDecoration(
                        color: Color(0XFF048c6c),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, $user!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Archivo_black',
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            '"Behind every young child who believes in himself is a parent who believed first"',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      'CURRENT STATUS',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 116, 116, 116),
                      ),
                    ),

                    SizedBox(height: 15),

                    // Sessions card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.25,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width * 0.93,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upcoming Sessions',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 108, 108, 108),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          Row(
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
                                  Icons.calendar_today_outlined,
                                  color: Color.fromARGB(255, 123, 102, 0),
                                ),
                              ),

                              SizedBox(width: 8),

                              Text(
                                '0',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    108,
                                    108,
                                    108,
                                  ),
                                  fontSize: 25,
                                  fontFamily: 'Archivo_black',
                                ),
                              ), // change to a real counter
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.93,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.25,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: MediaQuery.of(context).size.width * 0.46,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  'Sessions Done',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      108,
                                      108,
                                      108,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 8),
                                Row(
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
                                        Icons.check_circle_outline,
                                        color: Color(0xFF048c6c),
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    Text(
                                      '0',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          108,
                                          108,
                                          108,
                                        ),
                                        fontSize: 25,
                                        fontFamily: 'Archivo_black',
                                      ),
                                    ), // change to a real counter
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.25,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: MediaQuery.of(context).size.width * 0.46,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  'Referrals Sent',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      108,
                                      108,
                                      108,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 8),
                                Row(
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
                                        Icons.group_outlined,
                                        color: Color.fromARGB(255, 4, 20, 140),
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    Text(
                                      '0',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          108,
                                          108,
                                          108,
                                        ),
                                        fontSize: 25,
                                        fontFamily: 'Archivo_black',
                                      ),
                                    ), // change to a real counter
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      'UPCOMING SESSIONS',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 116, 116, 116),
                      ),
                    ),

                    SizedBox(height: 15),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.25,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width * 0.93,
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '-No upcoming sessions-',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 108, 108, 108),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
