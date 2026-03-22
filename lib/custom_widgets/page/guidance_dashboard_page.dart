import 'package:flutter/material.dart';

class GuidanceDashboardScreen extends StatelessWidget {
  const GuidanceDashboardScreen({super.key});

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
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(),
                      ),
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
                    'Welcome Counselor!',
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
                  tooltip: 'Monitor Students',
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
                  tooltip: 'Call Students',
                  icon: Icon(Icons.call),
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