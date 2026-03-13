import 'package:flutter/material.dart';
import '../custom_widgets/custom_field.dart';
import '../custom_widgets/radio_groups.dart';
import '../custom_widgets/page_container.dart';

class FamilyBackground extends StatefulWidget {

  // VoidCallbacks and Functions
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final VoidCallback addSiblings;
  final Function(int) removeSiblings;

  final String? sources;

  // Siblings Map
  final List<Map<String, TextEditingController>> siblings;

  // Father's Controllers
  final TextEditingController? fatherName;
  final TextEditingController? fatherAge;
  final TextEditingController? fatherOccupation;
  final TextEditingController? fatherOfficeAddress;
  final TextEditingController? fatherContact;

  // Mothers's Controllers
  final TextEditingController? motherName;
  final TextEditingController? motherAge;
  final TextEditingController? motherOccupation;
  final TextEditingController? motherOfficeAddress;
  final TextEditingController? motherContact;

  // Guardian's Controllers
  final TextEditingController? guardianName;
  final TextEditingController? guardianAge;
  final TextEditingController? guardianOccupation;
  final TextEditingController? guardianOfficeAddress;
  final TextEditingController? guardianContact;

  // Other Controllers
  final TextEditingController? annualIncome;
  final TextEditingController? otherSources;

  //Radio box Controllers
  final Function(String?) sourceOnChanged;

  const FamilyBackground({
    super.key,

    // Functions
    required this.nextPage,
    required this.previousPage,
    required this.addSiblings,
    required this.removeSiblings,

    this.sources,

    // Father's Details
    this.fatherName,
    this.fatherAge,
    this.fatherOccupation,
    this.fatherOfficeAddress,
    this.fatherContact,

    // Mother's Details
    this.motherName,
    this.motherAge,
    this.motherOccupation,
    this.motherOfficeAddress,
    this.motherContact,

    // Guardian's Details
    this.guardianName,
    this.guardianAge,
    this.guardianOccupation,
    this.guardianOfficeAddress,
    this.guardianContact,
    this.otherSources,

    // Other Details
    this.annualIncome,

    // Siblings
    required this.siblings,

    // Radio Box Properties
    required this.sourceOnChanged,
  });

  @override
  State<FamilyBackground> createState() => _FamilyBackgroundState();
}

class _FamilyBackgroundState extends State<FamilyBackground> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageContainer(
        pageTitle: 'Family Background',
        onNext: widget.nextPage,
        onPrevious: widget.previousPage,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  // Father's Details
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.family_restroom),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        child: Text(
                          "FATHER'S DETAILS",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Father's Name Field
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.fatherName,
                      readOnly: false,
                      icon: Icons.person_2,
                      label: "NAME",
                    ),
                  ),

                  // Father's Age
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.fatherAge,
                      readOnly: false,
                      icon: Icons.person_2,
                      label: "AGE",
                    ),
                  ),

                  // Father's Occupation
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.fatherOccupation,
                      readOnly: false,
                      icon: Icons.work,
                      label: "OCCUPATION",
                      hint: 'If none, please type N/A',
                    ),
                  ),

                  // Father's Office/Address
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.fatherOfficeAddress,
                      readOnly: false,
                      icon: Icons.location_city,
                      label: "OFFICE/ADDRESS",
                    ),
                  ),

                  // Father's Contact No.
                  Container(
                    padding: EdgeInsets.only(bottom: 40),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.fatherContact,
                      readOnly: false,
                      icon: Icons.phone,
                      label: "CONTACT NO.",
                      hint: '09XXXXXXXXX',
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.family_restroom),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        child: Text(
                          "MOTHER'S DETAILS",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Mother's Name Field
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.motherName,
                      readOnly: false,
                      icon: Icons.person_2,
                      label: "NAME",
                    ),
                  ),

                  // Mother's Age
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.motherAge,
                      readOnly: false,
                      icon: Icons.person_2,
                      label: "AGE",
                    ),
                  ),

                  // Mother's Occupation
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.motherOccupation,
                      readOnly: false,
                      icon: Icons.work,
                      label: "OCCUPATION",
                      hint: 'If none, please type N/A',
                    ),
                  ),

                  // Mother's Office/Address
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.motherOfficeAddress,
                      readOnly: false,
                      icon: Icons.location_city,
                      label: "OFFICE/ADDRESS",
                    ),
                  ),

                  // Mother's Contact No.
                  Container(
                    padding: EdgeInsets.only(bottom: 40),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.motherContact,
                      readOnly: false,
                      icon: Icons.phone,
                      label: "CONTACT NO.",
                      hint: '09XXXXXXXXX',
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.family_restroom),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        child: Text(
                          "GUARDIAN'S DETAILS",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Guardian's Name Field
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.guardianName,
                      readOnly: false,
                      icon: Icons.person_2,
                      label: "NAME",
                    ),
                  ),

                  // Guardian's Age
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.guardianAge,
                      readOnly: false,
                      icon: Icons.person_2,
                      label: "AGE",
                    ),
                  ),

                  // Guardian's Occupation
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.guardianOccupation,
                      readOnly: false,
                      icon: Icons.work,
                      label: "OCCUPATION",
                      hint: 'If none, please input N/A',
                    ),
                  ),

                  // Guardian's Office/Address
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.guardianOfficeAddress,
                      readOnly: false,
                      icon: Icons.location_city,
                      label: "OFFICE/ADDRESS",
                    ),
                  ),

                  // Guardian's Contact No.
                  Container(
                    padding: EdgeInsets.only(bottom: 40),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.guardianContact,
                      readOnly: false,
                      icon: Icons.phone,
                      label: "CONTACT NO.",
                      hint: '09XXXXXXXXX',
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.info_outline),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 20, left: 10),
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

                  // Estimated Annual Family Income
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      textController: widget.annualIncome,
                      readOnly: false,
                      icon: Icons.money,
                      label: "ANNUAL FAMILY INCOME",
                      hint: '₱0.00',
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RadioGroups(
                icon: Icons.source,
                radioTitle: 'SOURCES OF INCOME',
                options: ['SALARIES/WAGES', 'BUSINESS', 'OTHERS'],
                selectedValue: widget.sources,
                onChanged: widget.sourceOnChanged,
              ),
            ),

            Container(
              padding: EdgeInsets.only(bottom: 40),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.otherSources,
                readOnly: false,
                icon: Icons.list,
                label: "OTHER SOURCES",
                hint: 'If others, please specify',
                enabled: widget.sources == 'OTHERS',
              ),
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Icon(Icons.family_restroom),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 20),
                  child: Text(
                    'SIBLINGS',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Column(
              children: List.generate(widget.siblings.length, (index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomField(
                        icon: Icons.person_2,
                        textController: widget.siblings[index]["Name"],
                        label: "NAME", 
                        readOnly: false,
                      ),
                    ),

                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: CustomField(
                          icon: Icons.person_2,
                          textController: widget.siblings[index]["Age"],
                          label: "AGE", 
                          readOnly: false,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: CustomField(
                          icon: Icons.work,
                          textController: widget.siblings[index]["Occupation"],
                          label: "OCCUPATION/SCHOOL", 
                          readOnly: false,
                        ),

                      
                      ),

                      ElevatedButton(
                        onPressed: () => {
                          widget.removeSiblings(index)
                        }, 
                        child: Text("Remove Siblings")
                        )
                  ],
                );
              })
            ),
            ElevatedButton(
              onPressed: widget.addSiblings,
              child: Text("Add Sibling"),
            )
          ],
        ),
      ),
    );
  }
}
