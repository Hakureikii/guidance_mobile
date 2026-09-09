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

  // ── Unchanged logic ───────────────────────────────────────────────────────────

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
    screenAccess();
    getCredentials();
  }

  // ── Initials helper ───────────────────────────────────────────────────────────

  String get _initials {
    final f = (firstname ?? '').isNotEmpty ? firstname![0].toUpperCase() : '';
    final l = (lastname ?? '').isNotEmpty ? lastname![0].toUpperCase() : '';
    return '$f$l';
  }

  int nav = 3;

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
            color: Colors.white,
          ),
          onTap: (index) {
            setState(() => nav = index);
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/studentDashboard');
              return;
            }
            if (index == 1) {
              Navigator.pushReplacementNamed(context, '/referStudents');
              return;
            }
            if (index == 2) {
              Navigator.pushReplacementNamed(context, '/sessions');
              return;
            }
            if (index == 3) {
              Navigator.pushReplacementNamed(context, '/studentProfile');
              return;
            }
            if (index == 4) {
              Navigator.pushReplacementNamed(context, '/studentNotifications');
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

      body: firstname == null
          ? Center(child: CircularProgressIndicator(color: Color(0xFF048c6c)))
          : SingleChildScrollView(
              child: Column(
                children: [
                  // ── Green hero ───────────────────────────────────────────────
                  Container(
                    color: Color(0xFF048c6c),
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 32),
                    child: Column(
                      children: [
                        // Avatar with initials
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _initials,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          '$firstname $lastname',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 6),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Student',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Info card ────────────────────────────────────────────────
                  Transform.translate(
                    offset: Offset(0, -16),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _infoRow(
                            iconBg: Color(0xFFE1F5EE),
                            icon: Icons.person_2_outlined,
                            iconColor: Color(0xFF048c6c),
                            label: 'Full name',
                            value: '$firstname $lastname',
                          ),
                          _divider(),
                          _infoRow(
                            iconBg: Color(0xFFE6F1FB),
                            icon: Icons.credit_card_outlined,
                            iconColor: Color(0xFF185FA5),
                            label: 'Student ID',
                            value: '$studentId',
                          ),
                          _divider(),
                          _infoRow(
                            iconBg: Color(0xFFFAEEDA),
                            icon: Icons.email_outlined,
                            iconColor: Color(0xFF854F0B),
                            label: 'Email',
                            value: '$email',
                          ),
                          _divider(),
                          _infoRow(
                            iconBg: Color(0xFFEEEDFE),
                            icon: Icons.school_outlined,
                            iconColor: Color(0xFF534AB7),
                            label: 'Course',
                            value: '$course',
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Generate inventory button ─────────────────────────────────
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 14, 20),
                    child: GestureDetector(
                      onTap: () {
                        final Uri url = Uri.parse(
                          'http://127.0.0.1/Research_Backup/pdf/generate_pdf.html?student_id=$userId&token=$token',
                        );
                        launchUrl(url);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Color(0xFFE1F5EE),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.picture_as_pdf_outlined,
                                color: Color(0xFF048c6c),
                                size: 18,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Generate Individual Inventory',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Download your PDF record',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      color: Color(0xFF888780),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFF888780),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ── Logout button ─────────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 14, 24),
                    child: GestureDetector(
                      onTap: logoutModal,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Color(0xFFFCEBEB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.logout,
                                color: Color(0xFFA32D2D),
                                size: 18,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA32D2D),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFFA32D2D),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // ── Info row ──────────────────────────────────────────────────────────────────

  Widget _infoRow({
    required Color iconBg,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    color: Color(0xFF888780),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Divider ───────────────────────────────────────────────────────────────────

  Widget _divider() {
    return Divider(
      color: Colors.grey.withOpacity(0.25),
      thickness: 0.5,
      height: 0,
      indent: 14,
      endIndent: 14,
    );
  }
}
