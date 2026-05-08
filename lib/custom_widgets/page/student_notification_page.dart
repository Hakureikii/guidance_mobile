import 'package:flutter/material.dart';
import 'package:guidance/custom_widgets/custom_field.dart';
import 'package:guidance/custom_widgets/input_validators.dart';
import 'package:guidance/services/add_appointments/call_handler.dart';
import 'package:guidance/services/auth/logout_users.dart';
import 'package:guidance/services/auth/sessions.dart';
import 'package:guidance/services/notifications/notifications.dart';

class StudentNotificationsScreen extends StatefulWidget {
  const StudentNotificationsScreen({super.key});

  @override
  State<StudentNotificationsScreen> createState() =>
      _StudentNotificationsScreenState();
}

class _StudentNotificationsScreenState
    extends State<StudentNotificationsScreen> {
  String? role;
  dynamic notifications;
  TextEditingController reasonController = TextEditingController();

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

  void acceptAppointmentModal(int id) {
    // popup consent modal
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
          title: Text('Consent'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Privacy Commitment: All information shared—whether written, verbal, or digital—is strictly confidential. This protection is binding and remains in full effect before our first meeting, during the course of our sessions, and indefinitely after our professional relationship has ended.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                acceptAppointment(id);
              },
              child: Text('I understand'),
            ),
          ],
        );
      },
    );
  }

  void acceptAppointment(int id) async {
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    final response = await AcceptAppointment.acceptAppointment(id);
    if (response == 'accepted') {
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
            title: Text('Notice'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('You accepted the guidance call request')],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      print(response);
    }
  }

  void declineAppointmentModal(int id) {
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
          title: Text('Decline Call'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please state your reason'),
              SizedBox(height: 8),
              TextArea(
                textController: reasonController,
                validator: Validators.required,
                hint: 'State your reason',
                icon: Icons.notes,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                declineAppointment(id);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void declineAppointment(int id) async {
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    final response = await DeclineAppointment.declineAppointment(
      id,
      reasonController.text,
    );

    if (response == 'declined') {
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
            title: Text('Notice'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('You declined the guidance call request')],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      debugPrint(response.toString());
    }
  }

  void checkNotifications() async {
    final notif = await Notifications.studentNotifications();
    setState(() {
      notifications = notif;
    });
  }

  @override
  void initState() {
    super.initState();
    setRole();
    checkNotifications();
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

  int nav = 4;

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
              'Notifications',
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
      body: notifications == null
          ? SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Loading Notifications'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: double.infinity,
                          child: Text(
                            'Calls',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: const Color.fromARGB(255, 116, 116, 116),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),

                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              for (int i = 0; i < notifications.length; i++)
                                // Notifications Card
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(20),
                                  width:
                                      MediaQuery.of(context).size.width * 0.93,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 0.25,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'You are requested to visit the guidance office.',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(height: 8),

                                      Text(
                                        'When: ${notifications[i]['time']}',
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),

                                      Text(
                                        'Purpose: ${notifications[i]['purpose']}',
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),

                                      SizedBox(height: 8),

                                      Column(
                                        children: [
                                          notifications[i]['status'] ==
                                                  'Accepted'
                                              ? Container(
                                                  padding: EdgeInsets.all(5),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Color(0XFF048c6c),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.3,
                                                  child: Text(
                                                    'Accepted',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              : notifications[i]['status'] ==
                                                    'Declined'
                                              ? Container(
                                                  padding: EdgeInsets.all(5),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(255, 140, 4, 4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.3,
                                                  child: Text(
                                                    'Declined',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    OutlinedButton(
                                                      style:
                                                          OutlinedButton.styleFrom(
                                                            side: BorderSide(
                                                              color: Colors
                                                                  .redAccent,
                                                            ),
                                                            foregroundColor:
                                                                Colors
                                                                    .redAccent,
                                                          ),
                                                      onPressed: () {
                                                        declineAppointmentModal(
                                                          notifications[i]['referral_id']['referral_id'],
                                                        );
                                                      },
                                                      child: Text(
                                                        'Decline',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(width: 8),

                                                    OutlinedButton(
                                                      style:
                                                          OutlinedButton.styleFrom(
                                                            side: BorderSide(
                                                              color: Color(
                                                                0xFF048c6c,
                                                              ),
                                                            ),
                                                            foregroundColor:
                                                                Color(
                                                                  0xFF048c6c,
                                                                ),
                                                          ),
                                                      onPressed: () {
                                                        acceptAppointmentModal(
                                                          notifications[i]['referral_id']['referral_id'],
                                                        );
                                                      },
                                                      child: Text(
                                                        'Accept',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
