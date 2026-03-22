import 'package:flutter/material.dart';
import '../../custom_widgets/page/parent_dashboard_page.dart';

void main () {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ParentDashboard(),
  ));
}

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  @override
  Widget build(BuildContext context) {
    return ParentDashboardScreen();
  }
}