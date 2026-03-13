import 'package:flutter/material.dart';
import 'templates/form_personal_information.dart';
import 'templates/form_family_background.dart';
import 'templates/form_educational_background.dart';
import 'templates/form_health.dart';
import 'package:intl/intl.dart';
// import 'services/register_student/insert_data_inventory.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: InventoryForms()),
  );
}

class InventoryForms extends StatefulWidget {
  const InventoryForms({super.key});

  @override
  State<InventoryForms> createState() => _InventoryFormsState();
}

class _InventoryFormsState extends State<InventoryForms> {
  final PageController _pageController = PageController();

  Map <String, TextEditingController> personalInformationController = {
      "studentNo": TextEditingController(),
      "firstName": TextEditingController(),
      "middleName": TextEditingController(),
      "lastName": TextEditingController(),
      "nickname": TextEditingController(),
      "course": TextEditingController(),
      "year": TextEditingController(),
      "section": TextEditingController(),

      "othersStatus": TextEditingController(),

      "spouseName": TextEditingController(),
      "spouseContactNumber": TextEditingController(),

      "dateController": TextEditingController(),
      "placeOfBirth": TextEditingController(),      
      "studentAge": TextEditingController(),

      "otherGender": TextEditingController(),
      
      "presentAddress": TextEditingController(),
      "phoneNumber": TextEditingController(),
      "emailAddress": TextEditingController(),
      "religion": TextEditingController(),
      "provincialAddress": TextEditingController(),
      "homePhoneNumber": TextEditingController(),
      "otherLivingArrangement": TextEditingController(),
      "ipMemberField": TextEditingController(),
  };

  Map <String, TextEditingController> familyBackgroundController = {
    // Father's Details
    "fatherName": TextEditingController(),
    "fatherAge": TextEditingController(),
    "fatherOccupation": TextEditingController(),
    "fatherOfficeAddress": TextEditingController(),
    "fatherContact": TextEditingController(),

    // Mother's Details
    "motherName": TextEditingController(),
    "motherAge": TextEditingController(),
    "motherOccupation": TextEditingController(),
    "motherOfficeAddress": TextEditingController(),
    "motherContact": TextEditingController(),

    // Guardian's Details
    "guardianName": TextEditingController(),
    "guardianAge": TextEditingController(),
    "guardianOccupation": TextEditingController(),
    "guardianOfficeAddress": TextEditingController(),
    "guardianContact": TextEditingController(),

    // Other Details
    "annualIncome": TextEditingController(),
    "otherSources": TextEditingController(),
  };

  Map <String, TextEditingController> educationalBackgroundController = {
    // School Details
    "elementarySchool": TextEditingController(),
    "elementaryYearGraduated": TextEditingController(),
    "highSchool": TextEditingController(),
    "highschoolYearGraduated": TextEditingController(),
    "collegeSchool": TextEditingController(),
    "schoolOrganization": TextEditingController(),
    "extraCurricularActivities": TextEditingController(),
  };

  Map <String, TextEditingController> health = {
    "notGoodCondition": TextEditingController(),
    "disabilities": TextEditingController(),
  };

  List <Map<String, TextEditingController>> siblings = [];
  String? civilstatus;
  String? gender;
  String? livingArrangement;
  String? ipMember;

  String? sources;
  String? sourceOfIncome;

  String? healthCondition;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      personalInformationController["dateController"]!.text = DateFormat('MM/dd/yyyy').format(selectedDate);
    }
  }

  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  void addSiblings() {
    setState(() {
      siblings.add({
        "Name": TextEditingController(),
        "Age": TextEditingController(),
        "Occupation": TextEditingController(),
      });
    });
  }

  void removeSiblings(int index) {
    setState(() {
      siblings.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                PersonalInformationForm(
                  nextPage: nextPage,

                  civilStatus: civilstatus,
                  onStatusChanged: (value) {
                    setState(() {
                      civilstatus = value;
                    });
                  },

                  onTap: () {
                    _selectDate(context);
                  },

                  gender: gender,
                  genderOnChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },

                  livingArrangement: livingArrangement,
                  livingArrangementOnChanged: (value) {
                    setState(() {
                      livingArrangement = value;
                    });
                  },

                  ipMember: ipMember,
                  ipMemberOnChanged: (value) {
                    setState(() {
                      ipMember = value;
                    });
                  },

                  studentNoController: personalInformationController['studentNo'],
                  studentfNameController: personalInformationController['firstName'],
                  studentmNameController: personalInformationController['middleName'],
                  studentlNameController: personalInformationController['lastName'],
                  studentNicknameController: personalInformationController['nickname'],
                  studentCourse: personalInformationController['course'],
                  studentYear: personalInformationController['year'],
                  studentSection: personalInformationController['section'],
                  
                  othersStatus: personalInformationController['othersStatus'],

                  spouseName: personalInformationController['spouseName'],
                  spouseContactNumber: personalInformationController['spouseContactNumber'],

                  dateController: personalInformationController["dateController"],
                  placeOfBirth: personalInformationController['placeOfBirth'],
                  studentAge: personalInformationController['studentAge'],

                  otherGender: personalInformationController["otherGender"],

                  presentAddress: personalInformationController['presentAddress'],
                  phoneNumber: personalInformationController['phoneNumber'],
                  emailAddress: personalInformationController['emailAddress'],
                  religion: personalInformationController['religion'],
                  provincialAddress: personalInformationController['provincialAddress'],
                  homePhoneNumber: personalInformationController['homePhoneNumber'],
                  otherLivingArrangement: personalInformationController['otherLivingArrangement'],
                  ipMemberField: personalInformationController['ipMemberField'],
                  
                ),
          
                FamilyBackground(
                  nextPage: nextPage,
                  previousPage: previousPage,

                  addSiblings: addSiblings,
                  removeSiblings: removeSiblings,
                  siblings: siblings,

                  fatherName: familyBackgroundController["fatherName"],
                  fatherAge: familyBackgroundController["fatherAge"],
                  fatherOccupation: familyBackgroundController["fatherOccupation"],
                  fatherOfficeAddress: familyBackgroundController["fatherOfficeAddress"],
                  fatherContact: familyBackgroundController["fatherContact"],
                  
                  motherName: familyBackgroundController["motherName"],
                  motherAge: familyBackgroundController["motherAge"],
                  motherOccupation: familyBackgroundController["motherOccupation"],
                  motherOfficeAddress: familyBackgroundController["motherOfficeAddress"],
                  motherContact: familyBackgroundController["motherContact"],

                  guardianName: familyBackgroundController["guardianName"],
                  guardianAge: familyBackgroundController["guardianAge"],
                  guardianOccupation: familyBackgroundController["guardianOccupation"],
                  guardianOfficeAddress: familyBackgroundController["guardianOfficeAddress"],
                  guardianContact: familyBackgroundController["guardianContact"],

                  annualIncome: familyBackgroundController["annualIncome"],
                  otherSources: familyBackgroundController["otherSources"],

                  sources: sources,
                  sourceOnChanged: (value) {
                    setState(() {
                      sources = value;
                    });
                  },
                ),

                EducationalBackground(
                  nextPage: nextPage, 
                  previousPage: previousPage,

                  // Details
                  elementarySchool: educationalBackgroundController["elementarySchool"],
                  elementaryYearGraduated: educationalBackgroundController["elementaryYearGraduated"],
                  highSchool: educationalBackgroundController["highSchool"],
                  highschoolYearGraduated: educationalBackgroundController["highschoolYearGraduated"],
                  collegeSchool: educationalBackgroundController["collegeSchool"],
                  schoolOrganization: educationalBackgroundController["schoolOrganization"],
                  extraCurricularActivities: educationalBackgroundController["extraCurricularActivities"],

                  ),

                Health(
                  nextPage: nextPage,
                  previousPage: previousPage,

                  healthCondition: healthCondition,
                  healthConditionOnChanged: (value) {
                    setState(() {
                      healthCondition = value;
                    });
                  },

                  notGoodCondition: health["notGoodCondition"],
                  disabilities: health["disabilities"],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}