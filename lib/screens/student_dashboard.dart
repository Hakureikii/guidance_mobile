import 'package:flutter/material.dart';
import 'package:guidance/widgets/radio_groups.dart';
import 'package:guidance/services/analytics/data_count.dart';
import 'package:guidance/database/database_configuration.dart';
import 'package:guidance/services/notifications/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth/sessions.dart';
import '../../services/auth/logout_users.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: StudentDashboard()),
  );
}

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String? user;
  String? choices;
  dynamic referralSentCount;
  dynamic sessions;

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

    if (session == 'Student') {
      return;
    } else {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  void newUser() async {
    final sessions = await SharedPreferences.getInstance();
    final userId = sessions.getInt('userId');
    final user = await DatabaseConfiguration.client
        .from('student_tb')
        .select('assessed')
        .eq('student_id', userId.toString())
        .single();

    if (!user['assessed']) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          String? localChoice1 = choices;
          String? localChoice2 = choices;
          String? localChoice3 = choices;
          String? localChoice4 = choices;
          String? localChoice5 = choices;
          String? localChoice6 = choices;
          String? localChoice7 = choices;

          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                scrollable: true,
                title: Text('Assessment'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const Text('In the past month:'),
                    const SizedBox(height: 10),

                    const Text(
                      '1. Have you wished you were dead or wished you could go to sleep and not wake up?',
                    ),
                    const SizedBox(height: 10),
                    RadioGroups(
                      selectedValue: localChoice1,
                      radioTitle: null,
                      options: ['Yes', 'No'],
                      onChanged: (value) {
                        setDialogState(() {
                          localChoice1 = value;
                        });

                        // optional: sync with parent
                        choices = value;
                      },
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      '2. Have You actually had any thoughts of killing yourself?',
                    ),

                    const SizedBox(height: 10),
                    RadioGroups(
                      selectedValue: localChoice2,
                      radioTitle: null,
                      options: ['Yes', 'No'],
                      onChanged: (value) {
                        setDialogState(() {
                          localChoice2 = value;
                        });

                        // optional: sync with parent
                        choices = value;
                      },
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      '3. Have you been thinking about how you might do this?\nE.g "I thought about taking an overdose but i never made a specific plan as to when where or how I would actually do it... and I would never go through it."',
                    ),

                    const SizedBox(height: 10),
                    RadioGroups(
                      selectedValue: localChoice3,
                      radioTitle: null,
                      options: ['Yes', 'No'],
                      onChanged: localChoice2 == 'No'
                          ? null
                          : (value) {
                              setDialogState(() {
                                localChoice3 = value;
                              });

                              // optional: sync with parent
                              choices = value;
                            },
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      '4. Have you had these thoughts and had some intention of acting on them?\nAs opposed to "I have the thought but I definitely will not do anything about them."',
                    ),

                    const SizedBox(height: 10),
                    RadioGroups(
                      selectedValue: localChoice4,
                      radioTitle: null,
                      options: ['Yes', 'No'],
                      onChanged: localChoice2 == 'No'
                          ? null
                          : (value) {
                              setDialogState(() {
                                localChoice4 = value;
                              });

                              // optional: sync with parent
                              choices = value;
                            },
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      '5. Have you started to work out or worked out the details of how to kill yourself? Do you intend to carry out this plan?',
                    ),

                    const SizedBox(height: 10),
                    RadioGroups(
                      selectedValue: localChoice5,
                      radioTitle: null,
                      options: ['Yes', 'No'],
                      onChanged: localChoice2 == 'No'
                          ? null
                          : (value) {
                              setDialogState(() {
                                localChoice5 = value;
                              });

                              // optional: sync with parent
                              choices = value;
                            },
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      '6. Have you ever done anything, started to do anything, or prepared to do anything to end your life?\nExamples: Collected pills, obtained a gun, gave away valuabless, wrote a will or suicide note, took out pills but didnt swallow any, held a gun but changed your mind or it was grabbed from your hand, went to the roof but didnt jump; or actually took pills, tried to shoot yourself, cut yourself, tried to hang yourself, etc.',
                    ),

                    const SizedBox(height: 10),
                    RadioGroups(
                      selectedValue: localChoice6,
                      radioTitle: null,
                      options: ['Yes', 'No'],
                      onChanged: (value) {
                        setDialogState(() {
                          localChoice6 = value;
                        });

                        // optional: sync with parent
                        choices = value;
                      },
                    ),

                    const SizedBox(height: 10),

                    const Text('7. Was this within the past three months?'),

                    const SizedBox(height: 10),
                    RadioGroups(
                      selectedValue: localChoice7,
                      radioTitle: null,
                      options: ['Yes', 'No'],
                      onChanged: localChoice6 == 'No'
                          ? null
                          : (value) {
                              setDialogState(() {
                                localChoice7 = value;
                              });

                              // optional: sync with parent
                              choices = value;
                            },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      final sessions = await SharedPreferences.getInstance();
                      final userId = sessions.getInt('userId');
                      await DatabaseConfiguration.client
                          .from('student_tb')
                          .update({'assessed': true})
                          .eq('student_id', userId.toString());
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  void checkNotifications() async {
    await Notifications.studentNotifications();
  }

  void referralSent() async {
    final count = await Analytics.referralSent();
    setState(() {
      referralSentCount = count;
    });
  }

  void upcomingSessions() async {
    final count = await Analytics.upcomingSessions();
    setState(() {
      sessions = count;
    });
  }

  @override
  void initState() {
    super.initState();
    session();
    screenAccess();
    checkNotifications();
    newUser();
    referralSent();
    upcomingSessions();
  }

  int nav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.pushReplacementNamed(context, '/sessions'); // Session
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

      backgroundColor: Color(0xFFF4F6F5),
      floatingActionButton: FloatingActionButton(
        elevation: 6,
        backgroundColor: Color(0XFF5d8299),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        tooltip: 'Chat with AIGO',
        onPressed: () {},
        child: Icon(Icons.chat_bubble_outline, size: 20),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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

      body: Center(
        child: Column(
          children: [
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
                            '"Perhaps you’ve been assigned this mountain to show others that it can be moved."',
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
                                sessions == null ? '0' : '$sessions',
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
