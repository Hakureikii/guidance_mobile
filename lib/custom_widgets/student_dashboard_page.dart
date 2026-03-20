import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  Future <void> _link() async {
    final Uri url = Uri.parse('http://localhost:3000');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch url: $url');
    }
  }

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Container
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            color: Color(0xFF18c89f),
            child: Row(
              children: [
                // Space
                Container(width: MediaQuery.of(context).size.width * 0.2),

                // Title
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                // Logout button
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.logout),
                    onPressed: () {},
                    label: Text(''),
                  ),
                ),
              ],
            ),
          ),

          // Body Container
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Text(
                    'Welcome Student!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),),
                ),

                TextButton(onPressed: widget._link, child: Text('Link'))
              ],
            ),
          ),

          // Footer Container
          Container(
            color: Color(0xFF18c89f),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.11,
          ),

          
        ],
      ),
    );
  }
}
