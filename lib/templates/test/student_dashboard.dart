import 'package:flutter/material.dart';
import '../../custom_widgets/page/student_dashboard_page.dart';

void main () {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentDashboard(),
  ));
}

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return StudentDashboardScreen();
  }
}