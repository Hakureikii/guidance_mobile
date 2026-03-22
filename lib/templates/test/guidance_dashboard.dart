import 'package:flutter/material.dart';
import '../../custom_widgets/page/guidance_dashboard_page.dart';

void main () {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GuidanceDashboard(),
  ));
}

class GuidanceDashboard extends StatefulWidget {
  const GuidanceDashboard({super.key});

  @override
  State<GuidanceDashboard> createState() => _GuidanceDashboardState();
}

class _GuidanceDashboardState extends State<GuidanceDashboard> {
  @override
  Widget build(BuildContext context) {
    return GuidanceDashboardScreen();
  }
}