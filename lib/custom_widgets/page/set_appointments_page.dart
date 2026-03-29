import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth/logout_users.dart';
import '../custom_field.dart';
import '../radio_groups.dart';
import '../input_validators.dart';

class SetAppointmentsPage extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController studentIdController;
  final String? reasons;
  final Function(String?) reasonsOnChanged;
  final Function(String)? fieldOnChanged;
  final TextEditingController aboutController;
  final TextEditingController othersController;
  final VoidCallback submitAppointment;

  final ListView listView;

  final List<dynamic> namesuggestions;

  final GlobalKey<FormState> appointmentsKey;

  const SetAppointmentsPage({
    super.key,

    required this.appointmentsKey,
    required this.nameController,
    required this.studentIdController,
    required this.aboutController,
    required this.othersController,
    required this.reasonsOnChanged,
    required this.submitAppointment,
    this.reasons,
    this.fieldOnChanged,
    required this.namesuggestions,
    required this.listView
  });

  @override
  State<SetAppointmentsPage> createState() => _SetAppointmentsPageState();
}

class _SetAppointmentsPageState extends State<SetAppointmentsPage> {
  void logout() async {
    final user = await LogoutUsers.logout();

    if (user == 'session_clear') {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Header
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          color: Color(0xFF048c6c),
          child: Row(
            children: [
              // Space
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: IconButton(
                  onPressed: () async {
                    final session = await SharedPreferences.getInstance();
                    final role = session.getString('role');

                    if (role == 'Student') {
                      Navigator.pushReplacementNamed(
                        context,
                        '/studentDashboard',
                      );
                      return;
                    }

                    if (role == 'Faculty') {
                      Navigator.pushReplacementNamed(
                        context,
                        '/facultyDashboard',
                      );
                      return;
                    }

                    if (role == 'Parent') {
                      Navigator.pushReplacementNamed(
                        context,
                        '/parentDashboard',
                      );
                      return;
                    }
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),

              // Title
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Appointments',
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
                  onPressed: logout,
                ),
              ),
            ],
          ),
        ),

        // Body Container
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Text(
                    'Set Appointments',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Form(
                  key: widget.appointmentsKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomField(
                          fieldOnChanged: widget.fieldOnChanged,
                          validator: Validators.required,
                          textController: widget.nameController,
                          icon: Icons.person_2,
                          isObscured: false,
                          label: 'Name of Student',
                          readOnly: false,
                        ),
                      ),

                      if (widget.namesuggestions.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          constraints: BoxConstraints(maxHeight: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(blurRadius: 5, color: Colors.black12),
                            ],
                          ),
                          child: widget.listView,
                          
                        ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomField(
                          validator: Validators.required,
                          textController: widget.studentIdController,
                          icon: Icons.perm_identity,
                          isObscured: false,
                          label: 'Student ID',
                          readOnly: true,
                        ),
                      ),
                      RadioGroups(
                        icon: Icons.info,
                        radioTitle: 'Reasons for referral',
                        options: [
                          'needs vocational/educational counseling',
                          'needs individual counseling',
                        ],
                        selectedValue: widget.reasons,
                        onChanged: widget.reasonsOnChanged,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextArea(
                          label: 'About',
                          icon: Icons.info,
                          textController: widget.aboutController,
                          validator: Validators.required,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextArea(
                          label: 'Others',
                          hint: 'If none type N/A',
                          icon: Icons.info,
                          textController: widget.othersController,
                          validator: Validators.required,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: widget.submitAppointment,
                    style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(),
                      padding: EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 80,
                      ),
                      backgroundColor: Color(0xFF048c6c),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        letterSpacing: 3,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.black.withAlpha(20),
                  ),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                ),

                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                color: Colors.white,
                tooltip: 'Add Appointment',
                icon: Icon(Icons.document_scanner),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/setAppointments');
                },
              ),

              IconButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder()),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                color: Colors.white,
                tooltip: 'Profile',
                icon: Icon(Icons.person_2),
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
    );
  }
}
