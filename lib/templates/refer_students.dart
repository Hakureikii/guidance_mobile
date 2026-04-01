import 'package:flutter/material.dart';
import 'package:guidance/custom_widgets/page/refer_students_page.dart';
import 'package:guidance/custom_widgets/search_suggestions.dart';
import 'package:guidance/services/add_appointments/send_appointment.dart';

class ReferStudents extends StatefulWidget {
  const ReferStudents({super.key});

  @override
  State<ReferStudents> createState() => _ReferStudentsState();
}

class _ReferStudentsState extends State<ReferStudents> {
  String? reasons;
  TextEditingController nameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController othersController = TextEditingController();

  List<dynamic> namesuggestions = [];

  final _appointmentsKey = GlobalKey<FormState>();

  void searchsuggestions(String value) async {
    final names = await SearchSuggestions.suggestions(value);
    if (names.isEmpty) {
      setState(() {
        namesuggestions = [];
      });
      return;
    }

    setState(() {
      namesuggestions = names;
    });
  }

  void submit() async {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          title: Text('Sending Referral'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Please wait'),
            ],
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 1));

    final response = await SubmitAppointment.submitAppointment(
      nameController.text,
      studentIdController.text,
      reasons,
      aboutController.text,
      othersController.text,
    );

    if (response == 'Success') {
      nameController.clear();
      studentIdController.clear();
      aboutController.clear();
      othersController.clear();

      //Modal showing successful sending of appointment/referral
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
            title: Text('Notice:'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Referral Sent!')],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Done'),
              ),
            ],
          );
        },
      );

      return;
    }
  }

  void submitModal() async {
    if (!_appointmentsKey.currentState!.validate()) {
      return;
    }

    if (reasons == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select reason for referral")),
      );
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          title: Text('Notice:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The information you are about to submit will be forwarded to the appropriate personnel and may be monitored for evaluation and follow-up.\n\nThese details may be used as a basis for providing counseling support to the student. Please ensure that all information entered is accurate, truthful, and not fabricated.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('No'),
            ),
            TextButton(onPressed: submit, child: Text('Yes')),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    studentIdController.dispose();
    aboutController.dispose();
    othersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReferStudentsPage(
        listView: ListView.builder(
          shrinkWrap: true,
          itemCount: namesuggestions.length,
          itemBuilder: (context, index) {
            final student = namesuggestions[index];

            return ListTile(
              title: Text(student['full_name']),
              onTap: () {
                nameController.text = student['full_name'];
                studentIdController.text = student['student_id'].toString();

                setState(() {
                  namesuggestions.clear();
                });
              },
            );
          },
        ),
        namesuggestions: namesuggestions,
        appointmentsKey: _appointmentsKey,
        fieldOnChanged: (value) {
          searchsuggestions(value);
        },
        reasons: reasons,
        reasonsOnChanged: (value) => {
          setState(() {
            reasons = value;
          }),
        },
        nameController: nameController,
        studentIdController: studentIdController,
        aboutController: aboutController,
        othersController: othersController,
        submitAppointment: submitModal,
      ),
    );
  }
}
