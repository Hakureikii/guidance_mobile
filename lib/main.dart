import 'package:flutter/material.dart';
import 'package:guidance/services/register_student/insert_data_inventory.dart';
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

  Map<String, TextEditingController> personalInformationController = {
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

  Map<String, TextEditingController> familyBackgroundController = {
    // Father's Details
    "fatherFirstName": TextEditingController(),
    "fatherMiddleName": TextEditingController(),
    "fatherLastName": TextEditingController(),
    "fatherAge": TextEditingController(),
    "fatherOccupation": TextEditingController(),
    "fatherOfficeAddress": TextEditingController(),
    "fatherContact": TextEditingController(),

    // Mother's Details
    "motherFirstName": TextEditingController(),
    "motherMiddleName": TextEditingController(),
    "motherLastName": TextEditingController(),
    "motherAge": TextEditingController(),
    "motherOccupation": TextEditingController(),
    "motherOfficeAddress": TextEditingController(),
    "motherContact": TextEditingController(),

    // Guardian's Details
    "guardianFirstName": TextEditingController(),
    "guardianMiddleName": TextEditingController(),
    "guardianLastName": TextEditingController(),
    "guardianAge": TextEditingController(),
    "guardianOccupation": TextEditingController(),
    "guardianOfficeAddress": TextEditingController(),
    "guardianContact": TextEditingController(),

    // Other Details
    "annualIncome": TextEditingController(),
    "otherSources": TextEditingController(),
  };

  Map<String, TextEditingController> educationalBackgroundController = {
    // School Details
    "elementarySchool": TextEditingController(),
    "elementaryYearGraduated": TextEditingController(),
    "highSchool": TextEditingController(),
    "highschoolYearGraduated": TextEditingController(),
    "collegeSchool": TextEditingController(),
    "schoolOrganization": TextEditingController(),
    "extraCurricularActivities": TextEditingController(),
  };

  Map<String, TextEditingController> health = {
    "notGoodCondition": TextEditingController(),
    "disabilities": TextEditingController(),
  };

  List<Map<String, TextEditingController>> siblings = [];

  String? civilstatus;
  String? gender;
  String? livingArrangement;
  String? ipMember;

  String? sources;
  String? sourceOfIncome;

  String? healthCondition;

  Future<void> submitData() async {
    // Insert Student Details
    int? studentID = await InsertDataInventory.insertStudent(
      studentNo: personalInformationController["studentNo"]!.text,
      firstName: personalInformationController["firstName"]!.text,
      middleName: personalInformationController["middleName"]!.text,
      lastName: personalInformationController["lastName"]!.text,
      nickname: personalInformationController["nickname"]!.text,
      course: personalInformationController["course"]!.text,
      year: personalInformationController["year"]!.text,
      section: personalInformationController["section"]!.text,
      age: personalInformationController["studentAge"]!.text,
      placeOfBirth: personalInformationController["placeOfBirth"]!.text,
      dateOfBirth: personalInformationController["dateController"]!.text,
      gender: gender,
      emailAddress: personalInformationController["emailAddress"]!.text,
    );

    // Insert Civil Status
    await InsertDataInventory.insertCivilStatus(
      studentId: studentID,
      civilStatus: civilstatus,
      spouseName: personalInformationController["spouseName"]!.text,
      spouseContactNumber: personalInformationController["spouseContactNumber"]!.text,
    );

    // Insert student contact
    await InsertDataInventory.insertContact(
      studentId: studentID,
      presentAddress: personalInformationController["presentAddress"]!.text,
      phoneNumber: personalInformationController["phoneNumber"]!.text,
      provincialAddress: personalInformationController["provincialAddress"]!.text,
      homePhoneNumber: personalInformationController["homePhoneNumber"]!.text,
      ethnicGroup: ipMember,
      livingArrangement: livingArrangement,
    );

    // Insert Parent
    await InsertDataInventory.insertMother(
      studentId: studentID,
      lastName: familyBackgroundController["motherLastName"]!.text,
      firstName: familyBackgroundController["motherFirstName"]!.text,
      middleName: familyBackgroundController["motherMiddleName"]!.text,
      age: familyBackgroundController["motherAge"]!.text,
      address: familyBackgroundController["motherOfficeAddress"]!.text,
      contactNumber: familyBackgroundController["motherContact"]!.text,
      sourceOfIncome: sources,
      estimatedAnnualIncome: familyBackgroundController["annualIncome"]!.text,
      occupation: familyBackgroundController["motherOccupation"]!.text,
    );

    await InsertDataInventory.insertFather(
      studentId: studentID,
      lastName: familyBackgroundController["fatherLastName"]!.text,
      firstName: familyBackgroundController["fatherFirstName"]!.text,
      middleName: familyBackgroundController["fatherMiddleName"]!.text,
      age: familyBackgroundController["fatherAge"]!.text,
      address: familyBackgroundController["fatherOfficeAddress"]!.text,
      contactNumber: familyBackgroundController["fatherContact"]!.text,
      sourceOfIncome: sources,
      estimatedAnnualIncome: familyBackgroundController["annualIncome"]!.text,
      occupation: familyBackgroundController["fatherOccupation"]!.text,
    );

    await InsertDataInventory.insertGuardian(
      studentId: studentID,
      lastName: familyBackgroundController["guardianLastName"]!.text,
      firstName: familyBackgroundController["guardianFirstName"]!.text,
      middleName: familyBackgroundController["guardianMiddleName"]!.text,
      age: familyBackgroundController["guardianAge"]!.text,
      address: familyBackgroundController["guardianOfficeAddress"]!.text,
      contactNumber: familyBackgroundController["guardianContact"]!.text,
      sourceOfIncome: sources,
      estimatedAnnualIncome: familyBackgroundController["annualIncome"]!.text,
      occupation: familyBackgroundController["guardianOccupation"]!.text,
    );

    await InsertDataInventory.insertSiblings(
      studentId: studentID,
      siblings: siblings,
    );

    await InsertDataInventory.insertEducationalBackground(
      studentId: studentID,
      elementarySchool: educationalBackgroundController["elementarySchool"]!.text,
      elementaryYearGraduated: educationalBackgroundController["elementaryYearGraduated"]!.text,
      highSchool: educationalBackgroundController["highSchool"]!.text,
      highschoolYearGraduated: educationalBackgroundController["highschoolYearGraduated"]!.text,
      collegeSchool: educationalBackgroundController["collegeSchool"]!.text,
      schoolOrganization: educationalBackgroundController["schoolOrganization"]!.text,
      extraCurricularActivities: educationalBackgroundController["extraCurricularActivities"]!.text,
    );

    await InsertDataInventory.insertHealth(
      studentId: studentID,
      healthCondition: healthCondition,
      disabilities: health["disabilities"]!.text,
      notGoodCondition: health["notGoodCondition"]!.text,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      personalInformationController["dateController"]!.text = DateFormat(
        'MM/dd/yyyy',
      ).format(selectedDate);
    }
  }

  Future<void> _elementaryYearGraduated(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      educationalBackgroundController["elementaryYearGraduated"]!.text = DateFormat(
        'MM/dd/yyyy',
      ).format(selectedDate);
    }
  }

  Future<void> _highSchoolYearGraduated(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      educationalBackgroundController["highschoolYearGraduated"]!.text = DateFormat(
        'MM/dd/yyyy',
      ).format(selectedDate);
    }
  }

  void nextPage() {
    int currentPage = _pageController.page!.round();

    if (currentPage == 3) {
      submitData();
    } else {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubicEmphasized,
      );
    }
    // Radio Box Value Handler
    gender != 'Others' ? null : gender = personalInformationController["otherGender"]!.text;
    civilstatus != 'Others' ? null : civilstatus = personalInformationController["othersStatus"]!.text;
    ipMember != 'No' ? null : ipMember = personalInformationController["ipMemberField"]!.text;
    livingArrangement != 'Others' ? null : livingArrangement = personalInformationController["otherLivingArrangement"]!.text;
    sources != 'Others' ? null : sources = familyBackgroundController["otherSources"]!.text;
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
        "FirstName": TextEditingController(),
        "MiddleName": TextEditingController(),
        "LastName": TextEditingController(),
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

                  studentNoController:
                      personalInformationController['studentNo'],
                  studentfNameController:
                      personalInformationController['firstName'],
                  studentmNameController:
                      personalInformationController['middleName'],
                  studentlNameController:
                      personalInformationController['lastName'],
                  studentNicknameController:
                      personalInformationController['nickname'],
                  studentCourse: personalInformationController['course'],
                  studentYear: personalInformationController['year'],
                  studentSection: personalInformationController['section'],

                  othersStatus: personalInformationController['othersStatus'],

                  spouseName: personalInformationController['spouseName'],
                  spouseContactNumber:
                      personalInformationController['spouseContactNumber'],

                  dateController:
                      personalInformationController["dateController"],
                  placeOfBirth: personalInformationController['placeOfBirth'],
                  studentAge: personalInformationController['studentAge'],

                  otherGender: personalInformationController["otherGender"],

                  presentAddress:
                      personalInformationController['presentAddress'],
                  phoneNumber: personalInformationController['phoneNumber'],
                  emailAddress: personalInformationController['emailAddress'],
                  religion: personalInformationController['religion'],
                  provincialAddress:
                      personalInformationController['provincialAddress'],
                  homePhoneNumber:
                      personalInformationController['homePhoneNumber'],
                  otherLivingArrangement:
                      personalInformationController['otherLivingArrangement'],
                  ipMemberField: personalInformationController['ipMemberField'],
                ),

                FamilyBackground(
                  nextPage: nextPage,
                  previousPage: previousPage,

                  addSiblings: addSiblings,
                  removeSiblings: removeSiblings,
                  siblings: siblings,

                  fatherFirstName: familyBackgroundController["fatherFirstName"],
                  fatherMiddleName: familyBackgroundController["fatherMiddleName"],
                  fatherLastName: familyBackgroundController["fatherLastName"],
                  fatherAge: familyBackgroundController["fatherAge"],
                  fatherOccupation:
                      familyBackgroundController["fatherOccupation"],
                  fatherOfficeAddress:
                      familyBackgroundController["fatherOfficeAddress"],
                  fatherContact: familyBackgroundController["fatherContact"],

                  motherFirstName: familyBackgroundController["motherFirstName"],
                  motherMiddleName: familyBackgroundController["motherMiddleName"],
                  motherLastName: familyBackgroundController["motherLastName"],
                  motherAge: familyBackgroundController["motherAge"],
                  motherOccupation:
                      familyBackgroundController["motherOccupation"],
                  motherOfficeAddress:
                      familyBackgroundController["motherOfficeAddress"],
                  motherContact: familyBackgroundController["motherContact"],

                  guardianFirstName: familyBackgroundController["guardianFirstName"],
                  guardianMiddleName: familyBackgroundController["guardianMiddleName"],
                  guardianLastName: familyBackgroundController["guardianLastName"],
                  guardianAge: familyBackgroundController["guardianAge"],
                  guardianOccupation:
                      familyBackgroundController["guardianOccupation"],
                  guardianOfficeAddress:
                      familyBackgroundController["guardianOfficeAddress"],
                  guardianContact:
                      familyBackgroundController["guardianContact"],

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

                  elementaryYearGraduatedOnTap: () {
                    _elementaryYearGraduated(context);
                  },

                  highSchoolYearGraduatedOnTap: () {
                    _highSchoolYearGraduated(context);
                  },

                  // Details
                  elementarySchool:
                      educationalBackgroundController["elementarySchool"],
                  elementaryYearGraduated:
                      educationalBackgroundController["elementaryYearGraduated"],
                  highSchool: educationalBackgroundController["highSchool"],
                  highschoolYearGraduated:
                      educationalBackgroundController["highschoolYearGraduated"],
                  collegeSchool:
                      educationalBackgroundController["collegeSchool"],
                  schoolOrganization:
                      educationalBackgroundController["schoolOrganization"],
                  extraCurricularActivities:
                      educationalBackgroundController["extraCurricularActivities"],
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
