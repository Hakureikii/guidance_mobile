import 'package:flutter/material.dart';
import 'package:guidance/widgets/custom_field.dart';
import 'package:guidance/widgets/app_navigation.dart';
import 'package:guidance/utils/input_validators.dart';
import 'package:guidance/services/add_appointments/call_handler.dart';
import 'package:guidance/services/auth/logout_users.dart';
import 'package:guidance/services/auth/sessions.dart';
import 'package:guidance/services/notifications/notifications.dart';

class StudentNotifications extends StatefulWidget {
  const StudentNotifications({super.key});

  @override
  State<StudentNotifications> createState() => _StudentNotificationsState();
}

class _StudentNotificationsState extends State<StudentNotifications> {
  String role = '';
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
                if (context.mounted) Navigator.of(context).pop();
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
    if (context.mounted) Navigator.of(context).pop();
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
      if (context.mounted) Navigator.of(context).pop();
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
                if (context.mounted) Navigator.of(context).pop();
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
    if (context.mounted) Navigator.of(context).pop();

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
                  if (context.mounted) Navigator.of(context).pop();
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
                if (context.mounted) Navigator.of(context).pop();
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
    if (context.mounted) Navigator.of(context).pop();

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
                  if (context.mounted) Navigator.of(context).pop();
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

  void navigateBack() {
    if (role == 'Student') {
      Navigator.pushReplacementNamed(context, '/studentDashboard');
      return;
    }
    if (role == 'Parent') {
      Navigator.pushReplacementNamed(context, '/');
      return;
    }
    if (role == 'Guardian') {
      Navigator.pushReplacementNamed(context, '/');
      return;
    }
    if (role == 'Faculty') {
      Navigator.pushReplacementNamed(context, '/');
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    setRole();
    checkNotifications();
  }

  int nav = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6F5),

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

      bottomNavigationBar: AppNavigation.bottomNavigationBar(
        context: context,
        role: role,
        currentIndex: nav,
        onIndexChanged: (index) {
          setState(() {
            nav = index;
          });

          if (index == 0) {
            Navigator.pushReplacementNamed(
              context,
              '/studentDashboard',
            ); // Home
            return;
          }

          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/referStudents'); // Refer
            return;
          }

          if (index == 2) {
            role == 'Student'
                ? Navigator.pushReplacementNamed(context, '/sessions')
                : Navigator.pushReplacementNamed(
                    context,
                    '/monitorChild',
                  ); // Session
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
            if (role == 'Student') {
              Navigator.pushReplacementNamed(
                context,
                role == 'Student'
                    ? '/studentNotifications'
                    : role == 'Parent'
                    ? '/parentNotifications'
                    : role == 'Guardian'
                    ? '/guardianNotifications'
                    : '/facultyNotifications',
              ); // Notifications
              return;
            }
          }
        },
      ),

      body: notifications == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF048c6c)),
                  SizedBox(height: 12),
                  Text(
                    'Loading Notifications',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    'CALLS',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                  ),
                  SizedBox(height: 10),

                  notifications.isEmpty
                      ? _emptyState()
                      : Column(
                          children: [
                            for (int i = 0; i < notifications.length; i++)
                              _notificationCard(i),
                          ],
                        ),
                ],
              ),
            ),
    );
  }

  // ── Notification card ─────────────────────────────────────────────────────────

  Widget _notificationCard(int i) {
    final notif = notifications[i];
    final status = notif['status'] ?? '';
    final isPending = status != 'Accepted' && status != 'Declined';

    final iconBg = status == 'Accepted'
        ? Color(0xFFE1F5EE)
        : status == 'Declined'
        ? Color(0xFFFCEBEB)
        : Color(0xFFE1F5EE);

    final iconColor = status == 'Declined'
        ? Color(0xFFA32D2D)
        : Color(0xFF048c6c);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row — icon + message
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.phone_outlined, color: iconColor, size: 16),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'You are requested to visit the guidance office.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          // Meta rows
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 12,
                color: Color(0xFF888780),
              ),
              SizedBox(width: 5),
              Text(
                '${notif['time']}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  color: Color(0xFF888780),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 12,
                color: Color(0xFF888780),
              ),
              SizedBox(width: 5),
              Flexible(
                child: Text(
                  '${notif['purpose']}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: Color(0xFF888780),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Divider(
            color: Colors.black.withOpacity(0.07),
            thickness: 0.5,
            height: 0,
          ),

          SizedBox(height: 10),

          // Action area
          if (isPending)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.redAccent),
                    foregroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    declineAppointmentModal(
                      notifications[i]['referral_id']['referral_id'],
                    );
                  },
                  child: Text(
                    'Decline',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 11),
                  ),
                ),
                SizedBox(width: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF048c6c)),
                    foregroundColor: Color(0xFF048c6c),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    acceptAppointmentModal(notifications[i]['appointment_id']);
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 11),
                  ),
                ),
              ],
            )
          else
            _statusBadge(status),
        ],
      ),
    );
  }

  // ── Status badge ──────────────────────────────────────────────────────────────

  Widget _statusBadge(String status) {
    Color bg;
    Color fg;

    switch (status) {
      case 'Accepted':
        bg = Color(0xFFE1F5EE);
        fg = Color(0xFF0F6E56);
        break;
      case 'Declined':
        bg = Color(0xFFFCEBEB);
        fg = Color(0xFFA32D2D);
        break;
      default:
        bg = Color(0xFFFAEEDA);
        fg = Color(0xFF854F0B);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  // ── Empty state ───────────────────────────────────────────────────────────────

  Widget _emptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 36,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 10),
            Text(
              '-No notifications-',
              style: TextStyle(
                color: Color.fromARGB(255, 108, 108, 108),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
