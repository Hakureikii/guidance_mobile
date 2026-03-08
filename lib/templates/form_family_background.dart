import 'package:flutter/material.dart';
import '../custom_widgets/custom_field.dart';
import '../custom_widgets/radio_groups.dart';
import '../custom_widgets/page_container.dart';

class FamilyBackground extends StatefulWidget {
  final VoidCallback nextPage;
  final VoidCallback previousPage;

  const FamilyBackground({
    super.key,
    required this.nextPage,
    required this.previousPage,
  });

  @override
  State<FamilyBackground> createState() => _FamilyBackgroundState();
}

class _FamilyBackgroundState extends State<FamilyBackground> {
  String? sources;

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
                selectedValue: sources,
                onChanged: (value) {
                  setState(() {
                    sources = value;
                  });
                },
              ),
            ),

            Container(
              padding: EdgeInsets.only(bottom: 40),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.list,
                label: "OTHER SOURCES",
                hint: 'If others, please specify',
                enabled: sources == 'OTHERS',
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
          ],
        ),
      ),
    );
  }
}
