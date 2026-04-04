import 'package:flutter/material.dart';
import 'package:guidance/custom_widgets/page/student_notification_page.dart';

class StudentNotifications extends StatefulWidget {
  const StudentNotifications({super.key});

  @override
  State<StudentNotifications> createState() => _StudentNotificationsState();
}

class _StudentNotificationsState extends State<StudentNotifications> {
  @override
  Widget build(BuildContext context) {
    return StudentNotificationsScreen();
  }
}