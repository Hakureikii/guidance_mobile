import 'package:flutter/material.dart';
import '../../custom_widgets/page/guardian_dashboard_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return GuardianDashboardScreen();
  }
}
