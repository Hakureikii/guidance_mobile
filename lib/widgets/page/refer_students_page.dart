import 'package:flutter/material.dart';
import 'package:guidance/services/auth/sessions.dart';
import '../../services/auth/logout_users.dart';
import '../custom_field.dart';
import '../radio_groups.dart';
import '../../utils/input_validators.dart';
import '../../widgets/app_navigation.dart';

class ReferStudentsPage extends StatefulWidget {
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

  const ReferStudentsPage({
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
    required this.listView,
  });

  @override
  State<ReferStudentsPage> createState() => _ReferStudentsPage();
}

class _ReferStudentsPage extends State<ReferStudentsPage> {
  String role = '';

  void setRole() async {
    final session = await Sessions.validate();
    setState(() {
      role = session;
    });
  }

  @override
  void initState() {
    super.initState();
    setRole();
  }

  int nav = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation.appBar(
        context: context,
        title: 'Refer Student',
        role: role,
      ),

      bottomNavigationBar: AppNavigation.bottomNavigationBar(
        context: context,
        role: role,
        currentIndex: nav,
        onIndexChanged: (index) {
          setState(() {
            nav = index;
          });

          if (index == 0) {
            Navigator.pushReplacementNamed(
              context,
              '/studentDashboard',
            ); // Home
            return;
          }

          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/referStudents'); // Refer
            return;
          }

          if (index == 2) {
            role == 'Student' || role == 'Faculty'
                ? Navigator.pushReplacementNamed(context, '/sessions')
                : Navigator.pushReplacementNamed(
                    context,
                    '/monitorChild',
                  ); // Session
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
            ); // Profile
            return;
          }

          if (index == 4) {
            if (role == 'Student') {
              Navigator.pushReplacementNamed(
                context,
                role == 'Student'
                    ? '/studentNotifications'
                    : role == 'Parent'
                    ? '/parentNotifications'
                    : role == 'Guardian'
                    ? '/guardianNotifications'
                    : '/facultyNotifications',
              ); // Notifications
              return;
            }
          }
        },
      ),

      backgroundColor: Color(0xFFF4F6F5),

      floatingActionButton:
          role == 'Guardian' || role == 'Parent' || role == 'Faculty'
          ? null
          : FloatingActionButton(
              elevation: 6,
              backgroundColor: Color(0XFF5d8299),
              foregroundColor: Colors.white,
              shape: CircleBorder(),
              tooltip: 'Chat with AIGO',
              onPressed: () {},
              child: Icon(Icons.chat_bubble_outline, size: 20),
            ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Column(
        children: [
          // Body Container
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: double.infinity,
                    child: Text(
                      'Refer a Student',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: const Color.fromARGB(255, 116, 116, 116),
                      ),
                    ),
                  ),

                  SizedBox(height: 2),

                  Form(
                    key: widget.appointmentsKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: double.infinity,
                          child: Text(
                            'Fill in the details below to submit a referral',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: const Color.fromARGB(255, 116, 116, 116),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Student Information Card
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.25,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width * 0.93,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                child: Text(
                                  'Student Information',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      116,
                                      116,
                                      116,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              SizedBox(height: 8),

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
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.black12,
                                      ),
                                    ],
                                  ),
                                  child: widget.listView,
                                ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
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
                        ),

                        SizedBox(height: 15),

                        // Reasons for referral
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.25,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width * 0.93,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Reasons for referral',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),

                              SizedBox(height: 8),

                              RadioGroups(
                                icon: null,
                                radioTitle: null,
                                options: [
                                  'needs vocational/educational counseling',
                                  'needs individual counseling',
                                ],
                                selectedValue: widget.reasons,
                                onChanged: widget.reasonsOnChanged,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15),
                        // Additional Notes
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.25,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width * 0.93,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Additional Notes',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    116,
                                    116,
                                    116,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),

                              SizedBox(height: 15),

                              TextArea(
                                label: 'About',
                                icon: Icons.info,
                                textController: widget.aboutController,
                                validator: Validators.required,
                              ),

                              SizedBox(height: 15),

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
                        'SUBMIT',
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
        ],
      ),
    );
  }
}
