import 'package:flutter/material.dart';
import 'package:guidance/widgets/page/refer_students_page.dart';
import 'package:guidance/utils/search_suggestions.dart';
import 'package:guidance/services/add_appointments/send_appointment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReferStudents extends StatefulWidget {
  const ReferStudents({super.key});

  @override
  State<ReferStudents> createState() => _ReferStudentsState();
}

class _ReferStudentsState extends State<ReferStudents> {
  String? reasons;
  String? prediction;
  String? intensity;
  Map<String, String?> studentData = {};
  String? livingArrangement;
  String? parentsStatus;
  String? recentProblemRemarks;
  String? recentProblem;
  String? sampleVar;
  List<dynamic>? probabilities;
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

  Future<bool> sendToPython() async {
    final url = Uri.parse("http://127.0.0.1:5000/add");

    // Clear the previous referral's results so they can never be reused by mistake
    prediction = null;
    probabilities = null;
    intensity = null;

    try {
      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"studentData": studentData}),
          );
          // .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        debugPrint("Server error ${response.statusCode}: ${response.body}");
        return false;
      }

      final analysis = jsonDecode(response.body);
      setState(() {
        prediction = analysis["analysis"]["prediction"];
        probabilities = analysis["analysis"]["probabilities"];
        intensity = analysis["intensity"];
        
      });
      return true;
    } catch (e) {
      debugPrint("Could not reach the analysis server: $e");
      return false;
    }
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

    final bool analysisReceived = await sendToPython();

    studentData = {};

    if (context.mounted) {
      Navigator.of(context).pop();
    }

    if (!analysisReceived) {
      if (context.mounted) {
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
                    'The referral could not be analyzed. Please make sure the analysis server is running and try again.',
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
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
      return;
    }

    final response = await SubmitAppointment.submitAppointment(
      nameController.text,
      studentIdController.text,
      reasons,
      aboutController.text,
      othersController.text,
      prediction,
      intensity,
      probabilities,
    );

    if (response == 'Success') {
      nameController.clear();
      studentIdController.clear();
      aboutController.clear();
      othersController.clear();

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
    } else {
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
              children: [Text('Referral Not Sent!')],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
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

    studentData = {
      "referral_details": aboutController.text,
      "previous_session_problem": recentProblem,
      "session_history": recentProblemRemarks,
      "living_arrangement": livingArrangement,
      "family_status": parentsStatus,
    };

    debugPrint("Student Data: $studentData");

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
                livingArrangement = student['living_arrangement'];
                parentsStatus = student['parents_status'];
                recentProblem = student['problem'] ?? 'No previous session';
                recentProblemRemarks =
                    student['remarks'] ?? "No previous sessions on record";

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
