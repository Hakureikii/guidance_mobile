import 'package:flutter/material.dart';
import '../custom_widgets/custom_field.dart';
import '../custom_widgets/radio_groups.dart';
import '../custom_widgets/page_container.dart';

class PersonalInformationForm extends StatefulWidget {
  final VoidCallback nextPage;

  // Form Validators
  final FormFieldValidator<String> inputValidator;
  final FormFieldValidator<String> studentNoValidator;
  final FormFieldValidator<String> yearLevelValidator;
  final FormFieldValidator civilValidator;
  final FormFieldValidator marriedOthersValidator;
  final FormFieldValidator spouseNumberValidator;
  final FormFieldValidator<String> phoneNumberValidator;
  final FormFieldValidator<String> emailValidator;
  final FormFieldValidator<String> ageValidator;
  final FormFieldValidator genderValidator;
  final FormFieldValidator livingArrangementValidator;
  final FormFieldValidator ipMemberValidator;

  // Form Key
  final GlobalKey<FormState> formKey;

  // Date of birth on tap function
  final VoidCallback onTap;

  // Text Editing Controllers
  final TextEditingController? studentNoController;
  final TextEditingController? studentfNameController;
  final TextEditingController? studentmNameController;
  final TextEditingController? studentlNameController;
  final TextEditingController? studentNicknameController;
  final TextEditingController? studentCourse;
  final TextEditingController? studentYear;
  final TextEditingController? studentSection;

  final TextEditingController? othersStatus;

  final TextEditingController? spouseName;
  final TextEditingController? spouseContactNumber;

  // Other Details
  final TextEditingController? dateController;
  final TextEditingController? placeOfBirth;
  final TextEditingController? studentAge;

  final TextEditingController? otherGender;

  final TextEditingController? presentAddress;
  final TextEditingController? phoneNumber;
  final TextEditingController? emailAddress;
  final TextEditingController? religion;
  final TextEditingController? provincialAddress;
  final TextEditingController? homePhoneNumber;

  final TextEditingController? otherLivingArrangement;
  final TextEditingController? ipMemberField;

  // Living Arrangement

  // Radio Values
  final String? civilStatus;
  final String? gender;
  final String? livingArrangement;
  final String? ipMember;

  // Radio onChanged Property
  final Function(String?) onStatusChanged;
  final Function(String?) genderOnChanged;
  final Function(String?) livingArrangementOnChanged;
  final Function(String?) ipMemberOnChanged;

  const PersonalInformationForm({
    super.key,

    // Functions
    required this.nextPage,
    required this.onTap,

    // Form Validator
    required this.studentNoValidator,
    required this.inputValidator,
    required this.yearLevelValidator,
    required this.civilValidator,
    required this.marriedOthersValidator,
    required this.spouseNumberValidator,
    required this.genderValidator,
    required this.phoneNumberValidator,
    required this.emailValidator,
    required this.ageValidator,
    required this.livingArrangementValidator,
    required this.ipMemberValidator,


    // Form Key
    required this.formKey,

    // Radio box values and handlers
    this.civilStatus,
    required this.onStatusChanged,

    this.gender,
    required this.genderOnChanged,

    this.livingArrangement,
    required this.livingArrangementOnChanged,

    this.ipMember,
    required this.ipMemberOnChanged,

    // Text Controllers
    this.studentNoController,
    this.studentfNameController,
    this.studentmNameController,
    this.studentlNameController,
    this.studentNicknameController,
    this.studentCourse,
    this.studentYear,
    this.studentSection,

    this.othersStatus,

    this.spouseName,
    this.spouseContactNumber,

    this.dateController,
    this.placeOfBirth,
    this.studentAge,

    this.otherGender,

    this.presentAddress,
    this.phoneNumber,
    this.emailAddress,
    this.religion,
    this.provincialAddress,
    this.homePhoneNumber,
    this.otherLivingArrangement,
    this.ipMemberField,
  });

  @override
  State<PersonalInformationForm> createState() =>
      _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageContainer(
        onNext: widget.nextPage,
        pageTitle: 'Personal Information',
        child: Column(
          children: [
            SizedBox(
              child: Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    // Student No.
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomField(
                        validator: widget.studentNoValidator,
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
                        validator: widget.inputValidator,
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
                        validator: widget.inputValidator,
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
                        validator: widget.inputValidator,
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
                        validator: widget.inputValidator,
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
                        validator: widget.inputValidator,
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
                        validator: widget.inputValidator,
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
                        validator: widget.inputValidator,
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
                      options: ['Single', 'Married', 'Others'],
                      selectedValue: widget.civilStatus,
                      onChanged: widget.onStatusChanged,
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomField(
                        validator: widget.civilValidator,
                        textController: widget.othersStatus,
                        readOnly: false,
                        icon: Icons.list,
                        label: '',
                        hint: 'If others, please specify',
                        enabled: widget.civilStatus == 'Others',
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
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 10,
                                ),
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
                              validator: widget.marriedOthersValidator,
                              textController: widget.spouseName,
                              readOnly: false,
                              enabled:
                                  widget.civilStatus == 'Married' ||
                                  widget.civilStatus == 'Others',
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
                              validator: widget.spouseNumberValidator,
                              textController: widget.spouseContactNumber,
                              readOnly: false,
                              enabled:
                                  widget.civilStatus == 'Married' ||
                                  widget.civilStatus == 'Others',
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
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 10,
                                ),
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
                            validator: widget.inputValidator,
                            textController: widget.dateController,
                            hint: 'MM/DD/YYYY',
                            readOnly: true,
                            label: 'DATE OF BIRTH',
                            onTap: widget.onTap,
                          ),

                          // Place Of Birth
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CustomField(
                              validator: widget.inputValidator,
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
                              validator: widget.ageValidator,
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
                      options: ['Male', 'Female', 'Others'],
                      selectedValue: widget.gender,
                      onChanged: widget.genderOnChanged,
                    ),

                    // Gender Field
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomField(
                        validator: widget.genderValidator,
                        textController: widget.otherGender,
                        readOnly: false,
                        icon: Icons.list,
                        label: '',
                        hint: 'If others, please specify',
                        enabled: widget.gender == 'Others',
                      ),
                    ),

                    // Present Address Field
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomField(
                        validator: widget.inputValidator,
                        textController: widget.presentAddress,
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
                        validator: widget.phoneNumberValidator,
                        textController: widget.phoneNumber,
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
                        validator: widget.emailValidator,
                        textController: widget.emailAddress,
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
                        validator: widget.inputValidator,
                        textController: widget.religion,
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
                        validator: widget.inputValidator,
                        textController: widget.provincialAddress,
                        readOnly: false,
                        icon: Icons.location_city,
                        label: 'HOME/PROVINCIAL ADDRESS',
                      ),
                    ),

                    //Home Phone No. Field
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomField(
                        validator: widget.phoneNumberValidator,
                        textController: widget.homePhoneNumber,
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
                      options: [
                        'Living With Parents',
                        'Living With Relatives',
                        'Others',
                      ],
                      selectedValue: widget.livingArrangement,
                      onChanged: widget.livingArrangementOnChanged,
                    ),

                    // Living Arrangement Field
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomField(
                        validator: widget.livingArrangementValidator,
                        textController: widget.otherLivingArrangement,
                        readOnly: false,
                        icon: Icons.list,
                        label: '',
                        hint: 'If others, please specify',
                        enabled: widget.livingArrangement == 'Others',
                      ),
                    ),

                    // IP MEMBER
                    RadioGroups(
                      icon: Icons.group,
                      radioTitle: 'IP MEMBER',
                      options: ['Yes', 'No'],
                      selectedValue: widget.ipMember,
                      onChanged: widget.ipMemberOnChanged,
                    ),

                    // IP MEMEBER Field
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomField(
                        validator: widget.ipMemberValidator,
                        textController: widget.ipMemberField,
                        readOnly: false,
                        icon: Icons.list,
                        label: '',
                        hint: 'If yes, please specify',
                        enabled: widget.ipMember == 'Yes',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
