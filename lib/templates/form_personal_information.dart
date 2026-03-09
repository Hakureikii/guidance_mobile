import 'package:flutter/material.dart';
import '../custom_widgets/custom_field.dart';
import '../custom_widgets/radio_groups.dart';
import '../custom_widgets/page_container.dart';
import 'package:intl/intl.dart';

class PersonalInformationForm extends StatefulWidget {
  final VoidCallback nextPage;
  final TextEditingController? studentNoController;
  final TextEditingController? studentfNameController;
  final TextEditingController? studentmNameController;
  final TextEditingController? studentlNameController;
  final TextEditingController? studentNicknameController;
  final TextEditingController? studentCourse;
  final TextEditingController? studentYear;
  final TextEditingController? studentSection;

  final TextEditingController? placeOfBirth;
  final TextEditingController? studentAge;


  const PersonalInformationForm({
    super.key, 
    
    required this.nextPage,
    this.studentNoController,
    this.studentfNameController,
    this.studentmNameController,
    this.studentlNameController,
    this.studentNicknameController,
    this.studentCourse,
    this.studentYear,
    this.studentSection,
    this.placeOfBirth,
    this.studentAge
    });

  @override
  State<PersonalInformationForm> createState() =>
      _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  String? civilStatus;
  String? gender;
  String? livingArrangement;
  String? ipMember;

  // Field Values
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      // Format the date as needed (e.g., using the intl package's DateFormat)
      // Example format: 'MM/dd/yyyy'
      _dateController.text = DateFormat('MM/dd/yyyy').format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageContainer(
        onNext: widget.nextPage,
        pageTitle: 'Personal Information',
        child: Column(
          children: [
            // Student No.
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.studentNoController,
                readOnly: false,
                label: 'STUDENT NO.',
                icon: Icons.numbers,
                hint: 'XX-XXXX',
              ),
            ),

            // First Name
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.studentfNameController,
                readOnly: false,
                label: 'FIRST NAME',
                icon: Icons.person_2,
              ),
            ),

            // Middle Name
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.studentmNameController,
                readOnly: false,
                label: 'MIDDLE NAME',
                icon: Icons.person_2,
              ),
            ),

            // Last Name
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.studentlNameController,
                readOnly: false,
                label: 'LAST NAME',
                icon: Icons.person_2,
              ),
            ),

            // Nickname
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.studentNicknameController,
                readOnly: false,
                label: 'NICKNAME',
                icon: Icons.perm_identity,
              ),
            ),

            // Course
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.studentCourse,
                readOnly: false,
                label: 'COURSE',
                icon: Icons.menu_book,
                hint: 'eg. BS Information Technology',
              ),
            ),

            // Year Level
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.studentYear,
                readOnly: false,
                label: 'YEAR LEVEL',
                icon: Icons.school,
                hint: '1 / 2 / 3 / 4',
              ),
            ),

            // Section
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.studentSection,
                readOnly: false,
                label: 'SECTION',
                icon: Icons.group,
              ),
            ),

            // Civil Status
            RadioGroups(
              icon: Icons.group,
              radioTitle: 'CIVIL STATUS',
              options: ['SINGLE', 'MARRIED', 'OTHERS'],
              selectedValue: civilStatus,
              onChanged: (value) {
                setState(() {
                  civilStatus = value;
                });
              },
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.list,
                label: '',
                hint: 'If others, please specify',
                enabled: civilStatus == 'OTHERS',
              ),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Icon(Icons.family_restroom),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Text(
                          'SPOUSE',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Spouse Name
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      enabled:
                          civilStatus == 'MARRIED' || civilStatus == 'OTHERS',
                      label: 'SPOUSE NAME',
                      hint: 'eg. John Doe',
                      icon: Icons.group,
                    ),
                  ),

                  // Spouse Contact Number
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      enabled:
                          civilStatus == 'MARRIED' || civilStatus == 'OTHERS',
                      label: 'CONTACT NO.',
                      hint: '09XXXXXXXXX',
                      icon: Icons.group,
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.info_outline),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 10),
                        child: Text(
                          'OTHER DETAILS',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Date of Birth
                  CustomField(
                    icon: Icons.calendar_today,
                    textController: _dateController,
                    hint: 'MM/DD/YYYY',
                    readOnly: true,
                    label: 'DATE OF BIRTH',
                    onTap: () {
                      _selectDate(context);
                    },
                  ),

                  // Place Of Birth
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomField(
                      textController: widget.placeOfBirth,
                      label: 'PLACE OF BIRTH',
                      readOnly: false,
                      icon: Icons.location_city,
                    ),
                  ),

                  // Age
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomField(
                      textController: widget.studentAge,
                      label: 'AGE',
                      readOnly: false,
                      icon: Icons.person_2,
                    ),
                  ),
                ],
              ),
            ),
            // Gender
            RadioGroups(
              icon: Icons.transgender,
              radioTitle: 'GENDER',
              options: ['MALE', 'FEMALE', 'OTHERS'],
              selectedValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),

            // Gender Field
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.list,
                label: '',
                hint: 'If others, please specify',
                enabled: gender == 'OTHERS',
              ),
            ),

            // Present Address Field
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.location_city,
                label: 'PRESENT ADDRESS',
              ),
            ),

            // Phone No. Field
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.phone,
                label: 'PHONE NO.',
                hint: '09XXXXXXXXX',
              ),
            ),

            // Email Address Field
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.email,
                label: 'EMAIL ADDRESS',
                hint: 'johndoe@gmail.com',
              ),
            ),

            // Religion Field
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.church,
                label: 'RELIGION',
              ),
            ),


            // Home/Provincial Address Field
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.location_city,
                label: 'HOME/PROVINCIAL ADDRESS',
              ),
            ),

            //Home Phone No. Field
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.phone,
                label: 'HOME PHONE NO.',
                hint: '09XXXXXXXXX',
              ),
            ),

            // Living Arrangement
            RadioGroups(
              icon: Icons.home,
              radioTitle: 'LIVING ARRANGEMENT',
              options: ['LIVING WITH PARENTS', 'LIVING WITH RELATIVES', 'OTHERS'],
              selectedValue: livingArrangement,
              onChanged: (value) {
                setState(() {
                  livingArrangement = value;
                });
              },
            ),

            // Living Arrangement Field
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.list,
                label: '',
                hint: 'If others, please specify',
                enabled: livingArrangement == 'OTHERS',
              ),
            ),

            // IP MEMBER
            RadioGroups(
              icon: Icons.group,
              radioTitle: 'IP MEMBER',
              options: ['YES', 'NO'],
              selectedValue: ipMember,
              onChanged: (value) {
                setState(() {
                  ipMember = value;
                });
              },
            ),

            // Living Arrangement Field
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.list,
                label: '',
                hint: 'If yes, please specify',
                enabled: ipMember == 'YES',
              ),
            ),
          ],
        ),
      ),
    );
  }
}