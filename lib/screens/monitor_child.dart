import 'package:flutter/material.dart';
import '../../services/monitor_child.dart';
import 'package:guidance/services/auth/sessions.dart';
import '../widgets/app_navigation.dart';

class MonitorChild extends StatefulWidget {
  const MonitorChild({super.key});

  @override
  State<MonitorChild> createState() => _MonitorChildState();
}

class _MonitorChildState extends State<MonitorChild> {
  String role = '';

  // ── Data state ────────────────────────────────────────────────────────────────
  List<dynamic> childData = [];
  dynamic totalReferrals;
  dynamic acceptedReferrals;
  dynamic declinedReferrals;
  dynamic completedSessions;

  bool _loading = true;

  // ── Fetch all data ────────────────────────────────────────────────────────────

  void _loadAll() async {
    final data       = await MonitorChildData.getChildData();
    final total      = await MonitorChildData.getChildTotalReferrals();
    final accepted   = await MonitorChildData.getChildAcceptedReferrals();
    final declined   = await MonitorChildData.getChildDeclinedReferrals();
    final completed  = await MonitorChildData.getChildCompletedSessions();

    setState(() {
      childData          = data is List ? data : [];
      totalReferrals     = total;
      acceptedReferrals  = accepted;
      declinedReferrals  = declined;
      completedSessions  = completed;
      _loading           = false;
    });
  }

  void setRole() async {
    final session = await Sessions.validate();
    setState(() => role = session);
  }

  void navigateBack() {
    if (role == 'Student') {
      Navigator.pushReplacementNamed(context, '/studentDashboard');
      return;
    }
    if (role == 'Parent') {
      Navigator.pushReplacementNamed(context, '/parentDashboard');
      return;
    }
    if (role == 'Guardian') {
      Navigator.pushReplacementNamed(context, '/guardianDashboard');
      return;
    }
    if (role == 'Faculty') {
      Navigator.pushReplacementNamed(context, '/facultyDashboard');
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    setRole();
    _loadAll();
  }

  // ── Initials helper ───────────────────────────────────────────────────────────

  String _initials(dynamic child) {
    final f = (child['first_name'] as String? ?? '').isNotEmpty
        ? (child['first_name'] as String)[0].toUpperCase()
        : '';
    final l = (child['last_name'] as String? ?? '').isNotEmpty
        ? (child['last_name'] as String)[0].toUpperCase()
        : '';
    return '$f$l';
  }

  // ── Bottom sheet ──────────────────────────────────────────────────────────────

  void _showChildDetail(dynamic child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFFF4F6F5),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    margin: EdgeInsets.only(top: 12, bottom: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Sheet title
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 4, 20, 12),
                    child: Row(
                      children: [
                        Text(
                          'Child Details',
                          style: TextStyle(
                            fontFamily: 'Archivo_black',
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 0, color: Colors.black.withOpacity(0.07)),

                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.all(16),
                      children: [

                        // ── Avatar + name hero ─────────────────────────────────
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 8),
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF048c6c).withOpacity(0.15),
                                  border: Border.all(
                                    color: Color(0xFF048c6c).withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    _initials(child),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF048c6c),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${child['first_name']} ${child['last_name']}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE1F5EE),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${child['course']}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                    color: Color(0xFF0F6E56),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),

                        // ── Basic info card ────────────────────────────────────
                        _sheetSectionLabel('Basic Information'),
                        SizedBox(height: 8),
                        _sheetCard(
                          children: [
                            _sheetRow(Icons.person_outline_rounded,
                                'First name', child['first_name'] ?? 'N/A'),
                            _sheetDivider(),
                            _sheetRow(Icons.person_outline_rounded,
                                'Middle name', child['middle_name'] ?? 'N/A'),
                            _sheetDivider(),
                            _sheetRow(Icons.person_outline_rounded,
                                'Last name', child['last_name'] ?? 'N/A'),
                            _sheetDivider(),
                            _sheetRow(Icons.credit_card_outlined,
                                'Student number', child['student_number'] ?? 'N/A'),
                            _sheetDivider(),
                            _sheetRow(Icons.school_outlined,
                                'Course', child['course'] ?? 'N/A'),
                            _sheetDivider(),
                            _sheetRow(Icons.layers_outlined,
                                'Year', '${child['year'] ?? 'N/A'}'),
                            _sheetDivider(),
                            _sheetRow(Icons.group_outlined,
                                'Section', child['section'] ?? 'N/A'),
                          ],
                        ),

                        SizedBox(height: 16),

                        // ── Stats row ──────────────────────────────────────────
                        _sheetSectionLabel('Referral Summary'),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            _statCard('Total\nReferrals',
                                '$totalReferrals', Color(0xFF048c6c), Color(0xFFE1F5EE)),
                            SizedBox(width: 8),
                            _statCard('Accepted',
                                '$acceptedReferrals', Color(0xFF185FA5), Color(0xFFE6F1FB)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            _statCard('Declined',
                                '$declinedReferrals', Color(0xFFA32D2D), Color(0xFFFCEBEB)),
                            SizedBox(width: 8),
                            _statCard('Completed\nSessions',
                                '$completedSessions', Color(0xFF854F0B), Color(0xFFFAEEDA)),
                          ],
                        ),

                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ── Sheet helpers ─────────────────────────────────────────────────────────────

  Widget _sheetSectionLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        letterSpacing: 2,
        fontSize: 10,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 116, 116, 116),
      ),
    );
  }

  Widget _sheetCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _sheetRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: Color(0xFF048c6c)),
          SizedBox(width: 10),
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
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sheetDivider() {
    return Divider(
      height: 0,
      thickness: 0.5,
      color: Colors.grey.withOpacity(0.25),
      indent: 14,
      endIndent: 14,
    );
  }

  Widget _statCard(
      String label, String value, Color fg, Color bg) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.25),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Archivo_black',
                    fontSize: 16,
                    color: fg,
                    height: 1,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  color: Color(0xFF888780),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int nav = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6F5),

      appBar: AppNavigation.appBar(
        context: context,
        title: 'Monitor Child',
        role: role,
      ),

      bottomNavigationBar: AppNavigation.bottomNavigationBar(
        context: context,
        role: role,
        currentIndex: nav,
        onIndexChanged: (index) {
          setState(() => nav = index);

          if (index == 0) {
            navigateBack();
            return;
          }
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/referStudents');
            return;
          }
          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/monitorChild');
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
            );
            return;
          }
          if (index == 4) {
            Navigator.pushReplacementNamed(context, '/parentNotifications');
            return;
          }
        },
      ),

      body: _loading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF048c6c)))
          : childData.isEmpty
              ? _emptyState()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        'CHILDREN',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 116, 116, 116),
                        ),
                      ),
                      SizedBox(height: 10),
                      ...childData.map((child) => _childCard(child)),
                    ],
                  ),
                ),
    );
  }

  // ── Child card ────────────────────────────────────────────────────────────────

  Widget _childCard(dynamic child) {
    return GestureDetector(
      onTap: () => _showChildDetail(child),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.25),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF048c6c).withOpacity(0.12),
                border: Border.all(
                  color: Color(0xFF048c6c).withOpacity(0.25),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  _initials(child),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF048c6c),
                  ),
                ),
              ),
            ),

            SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${child['first_name']} ${child['last_name']}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.school_outlined,
                          size: 12, color: Color(0xFF888780)),
                      SizedBox(width: 4),
                      Text(
                        '${child['course']}',
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
                      Icon(Icons.layers_outlined,
                          size: 12, color: Color(0xFF888780)),
                      SizedBox(width: 4),
                      Text(
                        'Year ${child['year']} — Section ${child['section']}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: Color(0xFF888780),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Icon(Icons.chevron_right, color: Color(0xFF888780), size: 18),
          ],
        ),
      ),
    );
  }

  // ── Empty state ───────────────────────────────────────────────────────────────

  Widget _emptyState() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(14),
        padding: EdgeInsets.symmetric(vertical: 36),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.25),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.child_care, size: 36, color: Colors.grey.shade300),
              SizedBox(height: 10),
              Text(
                '-No child data found-',
                style: TextStyle(
                  color: Color.fromARGB(255, 108, 108, 108),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}