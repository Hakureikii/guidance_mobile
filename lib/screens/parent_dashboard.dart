import 'package:flutter/material.dart';
import 'package:guidance/services/analytics/data_count.dart';
import 'package:guidance/services/auth/logout_users.dart';
import 'package:guidance/services/auth/sessions.dart';
import '../widgets/app_navigation.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: ParentDashboard()),
  );
}

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  String? user;
  dynamic referralSentCount;

  void session() async {
    final username = await Sessions.username();

    setState(() {
      user = '$username';
    });
  }

  void screenAccess() async {
    final session = await Sessions.validate();
    if (session == 'no session') {
      Navigator.pushReplacementNamed(context, '/loginPage');
      return;
    }

    if (session == 'Parent') {
      return;
    } else {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  int nav = 0;

  void referralSent() async {
    final count = await Analytics.referralSent();
    setState(() {
      referralSentCount = count;
    });
    print(referralSentCount);
  }

  @override
  void initState() {
    super.initState();
    session();
    screenAccess();
    referralSent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppNavigation.appBar(
        context: context,
        title: 'Parent Dashboard',
        role: 'Parent',
      ),

      // Bottom NavBar
      bottomNavigationBar: AppNavigation.bottomNavigationBar(
        context: context,
        role: 'Parent',
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
                                      referralSentCount == null
                                          ? '0'
                                          : '$referralSentCount',
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
