import 'package:flutter/material.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Container
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            color: Color(0xFF048c6c),
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
                        fontFamily: 'Archivo_black',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                // Logout button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: IconButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.white,
                    icon: Icon(Icons.logout),
                    onPressed: () {},
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
                    'Welcome Parent!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer Container
          Container(
            color: Color(0xFF048c6c),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.11,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.white,
                  tooltip: 'Refer Individuals',
                  icon: Icon(Icons.group),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),

                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.white,
                  tooltip: 'Add Appointment',
                  icon: Icon(Icons.document_scanner),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),

                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.white,
                  tooltip: 'Monitor Children',
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),

                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.white,
                  tooltip: 'Notifications',
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
