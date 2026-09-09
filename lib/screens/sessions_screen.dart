import 'package:flutter/material.dart';
import '../../services/auth/sessions.dart';
import '../../services/auth/logout_users.dart';
import '../../services/sessions/student_sessions.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  String _activeFilter = 'all';
  List<dynamic> sessionData = [];

  void getSessionData() async {
    final data = await StudentSessions.sessions();
    setState(() {
      sessionData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getSessionData();
  }

  String _getDate(dynamic row) => row['appointment_date'] ?? '';
  String _getTime(dynamic row) => row['time'] ?? '';
  String _getStatus(dynamic row) => row['status'] ?? '';
  String _getTitle(dynamic row) => row['purpose'] ?? '';
  String _getCounselor(dynamic row) =>
      row['guidance_counselor_id']['first_name'] ?? '';

  // ── Helpers ───────────────────────────────────────────────────────────────────

  String _monthLabel(String date) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    final month = int.tryParse(date.split('-')[1]) ?? 1;
    return months[(month - 1).clamp(0, 11)];
  }

  String _dayLabel(String date) => date.split('-')[2];

  bool _isPast(String status) => status == 'completed' || status == 'cancelled';

  // ── Filtered views ────────────────────────────────────────────────────────────

  List<dynamic> get _upcoming =>
      sessionData.where((row) => _getStatus(row) == 'Accepted').toList();

  List<dynamic> get _past => sessionData.where((row) {
    final s = _getStatus(row);
    return s == 'Completed' || s == 'Declined' || s == 'Canceled';
  }).toList();

  List<dynamic> get _filtered {
    if (_activeFilter == 'all') return sessionData;
    return sessionData
        .where((row) => _getStatus(row) == _activeFilter)
        .toList();
  }

  // ── Summary counts ────────────────────────────────────────────────────────────

  int get _totalCount => sessionData.length;
  int get _upcomingCount => _upcoming.length;
  int get _completedCount =>
      sessionData.where((row) => _getStatus(row) == 'completed').length;
  int get _pendingCount =>
      sessionData.where((row) => _getStatus(row) == 'pending').length;

  // ── Logout ────────────────────────────────────────────────────────────────────

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

  int nav = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6F5),

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
        backgroundColor: Color(0xFF048c6c),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.12),
            Text(
              'My Sessions',
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

      body: Column(
        children: [
          // ── Summary strip ──────────────────────────────────────────────────
          Container(
            color: Color(0xFF048c6c),
            padding: EdgeInsets.fromLTRB(14, 0, 14, 20),
            child: Row(
              children: [
                _summaryPill('Total', _totalCount),
                SizedBox(width: 8),
                _summaryPill('Upcoming', _upcomingCount),
                SizedBox(width: 8),
                _summaryPill('Completed', _completedCount),
                SizedBox(width: 8),
                _summaryPill('Pending', _pendingCount),
              ],
            ),
          ),

          Expanded(
            child: sessionData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xFF048c6c)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15),

                        // ── Filter chips ─────────────────────────────────────
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              _filterChip('all', 'All'),
                              SizedBox(width: 7),
                              _filterChip('Accepted', 'Accepted'),
                              SizedBox(width: 7),
                              _filterChip('Completed', 'Completed'),
                              SizedBox(width: 7),
                              _filterChip('Declined', 'Declined'),
                              SizedBox(width: 7),
                              _filterChip('Cancelled', 'Cancelled'),
                            ],
                          ),
                        ),

                        SizedBox(height: 15),

                        // ── Session list ─────────────────────────────────────
                        if (_activeFilter == 'all') ...[
                          if (_upcoming.isNotEmpty) ...[
                            _sectionLabel('Upcoming'),
                            SizedBox(height: 8),
                            ..._upcoming.map((row) => _sessionCard(row)),
                            SizedBox(height: 6),
                          ],
                          if (_past.isNotEmpty) ...[
                            _sectionLabel('Past'),
                            SizedBox(height: 8),
                            ..._past.map((row) => _sessionCard(row)),
                          ],
                          if (_upcoming.isEmpty && _past.isEmpty) _emptyState(),
                        ] else ...[
                          if (_filtered.isEmpty)
                            _emptyState()
                          else
                            ..._filtered.map((row) => _sessionCard(row)),
                        ],

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ── Summary pill ─────────────────────────────────────────────────────────────

  Widget _summaryPill(String label, int value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$value',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Archivo_black',
                fontSize: 20,
                height: 1,
              ),
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontFamily: 'Poppins',
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ── Filter chip ──────────────────────────────────────────────────────────────

  Widget _filterChip(String value, String label) {
    final isActive = _activeFilter == value;
    return GestureDetector(
      onTap: () => setState(() => _activeFilter = value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF048c6c) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Color(0xFF048c6c) : Colors.black.withOpacity(0.1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : Color(0xFF555555),
          ),
        ),
      ),
    );
  }

  // ── Section label ────────────────────────────────────────────────────────────

  Widget _sectionLabel(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 11,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
        ),
      ),
    );
  }

  // ── Session card ─────────────────────────────────────────────────────────────

  Widget _sessionCard(dynamic row) {
    final status = _getStatus(row);
    final date = _getDate(row);
    final past = _isPast(status);

    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 14, right: 14),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date box
          Container(
            width: 44,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: past ? Color(0xFFF0F0F0) : Color(0xFFE1F5EE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _dayLabel(date),
                  style: TextStyle(
                    fontFamily: 'Archivo_black',
                    fontSize: 20,
                    color: past ? Color(0xFF888888) : Color(0xFF048c6c),
                    height: 1,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  _monthLabel(date),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9,
                    color: past ? Color(0xFFAAAAAA) : Color(0xFF0F6E56),
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTitle(row),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 12,
                      color: Color(0xFF888780),
                    ),
                    SizedBox(width: 4),
                    Text(
                      _getTime(row),
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
                      Icons.person_outline_rounded,
                      size: 12,
                      color: Color(0xFF888780),
                    ),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        _getCounselor(row),
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
                SizedBox(height: 7),
                _statusBadge(status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Status badge ─────────────────────────────────────────────────────────────

  Widget _statusBadge(String status) {
    Color bg;
    Color fg;
    String label;

    switch (status) {
      case 'Accepted':
        bg = Color(0xFFE1F5EE);
        fg = Color(0xFF0F6E56);
        label = 'Accepted';
        break;
      case 'Completed':
        bg = Color(0xFFF0F0F0);
        fg = Color(0xFF666666);
        label = 'Completed';
        break;
      case 'Declined':
        bg = Color(0xFFFCEBEB);
        fg = Color(0xFFA32D2D);
        label = 'Declined';
        break;
      case 'Canceled':
        bg = Color(0xFFFAEEDA);
        fg = Color(0xFF854F0B);
        label = 'Canceled';
        break;
      default:
        bg = Color(0xFFF0F0F0);
        fg = Color(0xFF666666);
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  // ── Empty state ──────────────────────────────────────────────────────────────

  Widget _emptyState() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14),
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
              Icons.calendar_today_outlined,
              size: 36,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 10),
            Text(
              '-No sessions found-',
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
