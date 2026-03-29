import 'package:flutter/material.dart';
import 'package:guidance/custom_widgets/page/set_appointments_page.dart';
import 'package:guidance/custom_widgets/search_suggestions.dart';
import 'package:guidance/services/add_appointments/send_appointment.dart';

class SetAppointments extends StatefulWidget {
  const SetAppointments({super.key});

  @override
  State<SetAppointments> createState() => SetAppointmentsState();
}

class SetAppointmentsState extends State<SetAppointments> {
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
    if (!_appointmentsKey.currentState!.validate()) {
      return;
    }

    if (reasons == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select reason for referral")),
      );
      return;
    }

    final response = await SubmitAppointment.submitAppointment(
      nameController.text,
      studentIdController.text,
      reasons,
      aboutController.text,
      othersController.text,
    );

    print(response);

    if (response == 'Success') {
      nameController.clear();
      studentIdController.clear();
      aboutController.clear();
      othersController.clear();
      //Modal showing successful sending of appointment/referral
      return;
    }
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
      body: SetAppointmentsPage(
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
        submitAppointment: submit,
      ),
    );
  }
}
