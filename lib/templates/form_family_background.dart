// import 'package:flutter/material.dart';
// import '../custom_widgets/custom_field.dart';
// import '../custom_widgets/radio_groups.dart';
// import '../custom_widgets/page_container.dart';

// class FamilyBackground extends StatefulWidget {
//   // VoidCallbacks and Functions
//   final VoidCallback nextPage;
//   final VoidCallback previousPage;
//   final VoidCallback addSiblings;
//   final Function(int) removeSiblings;

//   // Form Validator
//   final FormFieldValidator<String> inputValidator;
//   final FormFieldValidator<String> ageValidator;
//   final FormFieldValidator<String> phoneNumberValidator;
//   final FormFieldValidator incomeValidator;

//   // Form Key
//   final GlobalKey<FormState> formKey;

//   final String? sources;

//   // Siblings Map
//   final List<Map<String, TextEditingController>> siblings;

//   // Father's Controllers
//   final TextEditingController? fatherFirstName;
//   final TextEditingController? fatherMiddleName;
//   final TextEditingController? fatherLastName;
//   final TextEditingController? fatherAge;
//   final TextEditingController? fatherOccupation;
//   final TextEditingController? fatherOfficeAddress;
//   final TextEditingController? fatherContact;

//   // Mothers's Controllers
//   final TextEditingController? motherFirstName;
//   final TextEditingController? motherMiddleName;
//   final TextEditingController? motherLastName;
//   final TextEditingController? motherAge;
//   final TextEditingController? motherOccupation;
//   final TextEditingController? motherOfficeAddress;
//   final TextEditingController? motherContact;

//   // Guardian's Controllers
//   final TextEditingController? guardianFirstName;
//   final TextEditingController? guardianMiddleName;
//   final TextEditingController? guardianLastName;
//   final TextEditingController? guardianAge;
//   final TextEditingController? guardianOccupation;
//   final TextEditingController? guardianOfficeAddress;
//   final TextEditingController? guardianContact;

//   // Other Controllers
//   final TextEditingController? annualIncome;
//   final TextEditingController? otherSources;

//   //Radio box Controllers
//   final Function(String?) sourceOnChanged;

//   const FamilyBackground({
//     super.key,

//     // Functions
//     required this.nextPage,
//     required this.previousPage,
//     required this.addSiblings,
//     required this.removeSiblings,

//     // Form Validator
//     required this.inputValidator,
//     required this.ageValidator,
//     required this.phoneNumberValidator,
//     required this.incomeValidator,

//     // Form Key
//     required this.formKey,

//     this.sources,

//     // Father's Details
//     this.fatherFirstName,
//     this.fatherMiddleName,
//     this.fatherLastName,
//     this.fatherAge,
//     this.fatherOccupation,
//     this.fatherOfficeAddress,
//     this.fatherContact,

//     // Mother's Details
//     this.motherFirstName,
//     this.motherMiddleName,
//     this.motherLastName,
//     this.motherAge,
//     this.motherOccupation,
//     this.motherOfficeAddress,
//     this.motherContact,

//     // Guardian's Details
//     this.guardianFirstName,
//     this.guardianMiddleName,
//     this.guardianLastName,
//     this.guardianAge,
//     this.guardianOccupation,
//     this.guardianOfficeAddress,
//     this.guardianContact,
//     this.otherSources,

//     // Other Details
//     this.annualIncome,

//     // Siblings
//     required this.siblings,

//     // Radio Box Properties
//     required this.sourceOnChanged,
//   });

//   @override
//   State<FamilyBackground> createState() => _FamilyBackgroundState();
// }

// class _FamilyBackgroundState extends State<FamilyBackground> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: PageContainer(
//         pageTitle: 'Family Background',
//         onNext: widget.nextPage,
//         onPrevious: widget.previousPage,
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(top: 20),
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: Column(
//                 children: [
//                   Form(
//                     key: widget.formKey,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 20),
//                               child: Icon(Icons.family_restroom),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 10,
//                                 bottom: 20,
//                               ),
//                               child: Text(
//                                 "FATHER'S DETAILS",
//                                 style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 14.5,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         // Father's Name Field
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.fatherFirstName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "FIRST NAME",
//                           ),
//                         ),

//                         // Father's Details
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.fatherMiddleName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "MIDDLE NAME",
//                           ),
//                         ),

//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.fatherLastName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "LAST NAME",
//                           ),
//                         ),

//                         // Father's Age
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.ageValidator,
//                             textController: widget.fatherAge,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "AGE",
//                           ),
//                         ),

//                         // Father's Occupation
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.fatherOccupation,
//                             readOnly: false,
//                             icon: Icons.work,
//                             label: "OCCUPATION",
//                             hint: 'If none, please type N/A',
//                           ),
//                         ),

//                         // Father's Office/Address
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.fatherOfficeAddress,
//                             readOnly: false,
//                             icon: Icons.location_city,
//                             label: "OFFICE/ADDRESS",
//                           ),
//                         ),

//                         // Father's Contact No.
//                         Container(
//                           padding: EdgeInsets.only(bottom: 40),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.phoneNumberValidator,
//                             textController: widget.fatherContact,
//                             readOnly: false,
//                             icon: Icons.phone,
//                             label: "CONTACT NO.",
//                             hint: '09XXXXXXXXX',
//                           ),
//                         ),

//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 20),
//                               child: Icon(Icons.family_restroom),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 10,
//                                 bottom: 20,
//                               ),
//                               child: Text(
//                                 "MOTHER'S DETAILS",
//                                 style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 14.5,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         // Mother's Name Field
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.motherFirstName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "FIRST NAME",
//                           ),
//                         ),

//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.motherMiddleName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "MIDDLE NAME",
//                           ),
//                         ),

//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.motherLastName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "LAST NAME",
//                           ),
//                         ),

//                         // Mother's Age
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.ageValidator,
//                             textController: widget.motherAge,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "AGE",
//                           ),
//                         ),

//                         // Mother's Occupation
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.motherOccupation,
//                             readOnly: false,
//                             icon: Icons.work,
//                             label: "OCCUPATION",
//                             hint: 'If none, please type N/A',
//                           ),
//                         ),

//                         // Mother's Office/Address
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.motherOfficeAddress,
//                             readOnly: false,
//                             icon: Icons.location_city,
//                             label: "OFFICE/ADDRESS",
//                           ),
//                         ),

//                         // Mother's Contact No.
//                         Container(
//                           padding: EdgeInsets.only(bottom: 40),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.phoneNumberValidator,
//                             textController: widget.motherContact,
//                             readOnly: false,
//                             icon: Icons.phone,
//                             label: "CONTACT NO.",
//                             hint: '09XXXXXXXXX',
//                           ),
//                         ),

//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 20),
//                               child: Icon(Icons.family_restroom),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 10,
//                                 bottom: 20,
//                               ),
//                               child: Text(
//                                 "GUARDIAN'S DETAILS",
//                                 style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 14.5,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         // Guardian's Name Field
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.guardianFirstName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "FIRST NAME",
//                           ),
//                         ),

//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.guardianMiddleName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "MIDDLE NAME",
//                           ),
//                         ),

//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.guardianLastName,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "LAST NAME",
//                           ),
//                         ),

//                         // Guardian's Age
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.ageValidator,
//                             textController: widget.guardianAge,
//                             readOnly: false,
//                             icon: Icons.person_2,
//                             label: "AGE",
//                           ),
//                         ),

//                         // Guardian's Occupation
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.guardianOccupation,
//                             readOnly: false,
//                             icon: Icons.work,
//                             label: "OCCUPATION",
//                             hint: 'If none, please input N/A',
//                           ),
//                         ),

//                         // Guardian's Office/Address
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.guardianOfficeAddress,
//                             readOnly: false,
//                             icon: Icons.location_city,
//                             label: "OFFICE/ADDRESS",
//                           ),
//                         ),

//                         // Guardian's Contact No.
//                         Container(
//                           padding: EdgeInsets.only(bottom: 40),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.phoneNumberValidator,
//                             textController: widget.guardianContact,
//                             readOnly: false,
//                             icon: Icons.phone,
//                             label: "CONTACT NO.",
//                             hint: '09XXXXXXXXX',
//                           ),
//                         ),

//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 20),
//                               child: Icon(Icons.info_outline),
//                             ),

//                             Padding(
//                               padding: EdgeInsets.only(bottom: 20, left: 10),
//                               child: Text(
//                                 'OTHER DETAILS',
//                                 style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 14.5,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         // Estimated Annual Family Income
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.inputValidator,
//                             textController: widget.annualIncome,
//                             readOnly: false,
//                             icon: Icons.money,
//                             label: "ANNUAL FAMILY INCOME",
//                             hint: '₱0.00',
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: RadioGroups(
//                             icon: Icons.source,
//                             radioTitle: 'SOURCES OF INCOME',
//                             options: ['Salaries/Wages', 'Business', 'Others'],
//                             selectedValue: widget.sources,
//                             onChanged: widget.sourceOnChanged,
//                           ),
//                         ),

//                         Container(
//                           padding: EdgeInsets.only(bottom: 40),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: CustomField(
//                             validator: widget.incomeValidator,
//                             textController: widget.otherSources,
//                             readOnly: false,
//                             icon: Icons.list,
//                             label: "OTHER SOURCES",
//                             hint: 'If others, please specify',
//                             enabled: widget.sources == 'Others',
//                           ),
//                         ),

//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 20,
//                                 bottom: 20,
//                               ),
//                               child: Icon(Icons.family_restroom),
//                             ),

//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 10,
//                                 bottom: 20,
//                               ),
//                               child: Text(
//                                 'SIBLINGS',
//                                 style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 14.5,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         Column(
//                           children: List.generate(widget.siblings.length, (
//                             index,
//                           ) {
//                             return Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                         bottom: 20,
//                                       ),
//                                       child: Icon(Icons.family_restroom),
//                                     ),

//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 10,
//                                         bottom: 20,
//                                       ),
//                                       child: Text(
//                                         'SIBLING ${index + 1}',
//                                         style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           fontSize: 14.5,
//                                           fontWeight: FontWeight.w900,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 // Siblings Name
//                                 Container(
//                                   padding: EdgeInsets.only(bottom: 20),
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                   child: CustomField(
//                                     icon: Icons.person_2,
//                                     validator: widget.inputValidator,
//                                     textController:
//                                         widget.siblings[index]["FirstName"],
//                                     label: "FIRST NAME",
//                                     readOnly: false,
//                                   ),
//                                 ),

//                                 Container(
//                                   padding: EdgeInsets.only(bottom: 20),
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                   child: CustomField(
//                                     icon: Icons.person_2,
//                                     validator: widget.inputValidator,
//                                     textController:
//                                         widget.siblings[index]["MiddleName"],
//                                     label: "MIDDLE NAME",
//                                     readOnly: false,
//                                   ),
//                                 ),

//                                 Container(
//                                   padding: EdgeInsets.only(bottom: 20),
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                   child: CustomField(
//                                     icon: Icons.person_2,
//                                     validator: widget.inputValidator,
//                                     textController:
//                                         widget.siblings[index]["LastName"],
//                                     label: "LAST NAME",
//                                     readOnly: false,
//                                   ),
//                                 ),

//                                 Container(
//                                   padding: EdgeInsets.only(bottom: 20),
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                   child: CustomField(
//                                     icon: Icons.person_2,
//                                     validator: widget.ageValidator,
//                                     textController:
//                                         widget.siblings[index]["Age"],
//                                     label: "AGE",
//                                     readOnly: false,
//                                   ),
//                                 ),

//                                 Container(
//                                   padding: EdgeInsets.only(bottom: 20),
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                   child: CustomField(
//                                     icon: Icons.work,
//                                     validator: widget.inputValidator,
//                                     textController:
//                                         widget.siblings[index]["Occupation"],
//                                     label: "OCCUPATION/SCHOOL",
//                                     readOnly: false,
//                                   ),
//                                 ),

//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 20),
//                                   child: ElevatedButton.icon(
//                                     icon: Icon(Icons.remove),
//                                     style: ElevatedButton.styleFrom(
//                                       padding: EdgeInsets.all(20),
//                                       backgroundColor: Colors.blueGrey,
//                                       foregroundColor: Colors.white,
//                                       shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(15),
//                                         ),
//                                       ),
//                                     ),
//                                     onPressed: () => {
//                                       widget.removeSiblings(index),
//                                     },
//                                     label: Text("Sibling"),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 20),
//                           child: ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               padding: EdgeInsets.all(20),
//                               backgroundColor: Colors.blueGrey,
//                               foregroundColor: Colors.white,
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(15),
//                                 ),
//                               ),
//                             ),
//                             icon: Icon(Icons.add_circle),
//                             label: Text("Sibling"),
//                             onPressed: widget.addSiblings,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
