import 'package:flutter/material.dart';
import '../custom_widgets/page_container.dart';
import '../custom_widgets/custom_field.dart';

class EducationalBackground extends StatefulWidget {
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  const EducationalBackground({
    super.key,
    required this.nextPage,
    required this.previousPage,
  });

  @override
  State<EducationalBackground> createState() => _EducationalBackgroundState();
}

class _EducationalBackgroundState extends State<EducationalBackground> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageContainer(
        pageTitle: 'Educational Background',
        onNext: widget.nextPage,
        onPrevious: widget.previousPage,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.school),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        child: Text(
                          'SCHOOLS',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Elementary School
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      icon: Icons.school_outlined,
                      label: "ELEMENTARY SCHOOL",
                    ),
                  ),

                  // Year Graduated on Elementary
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      icon: Icons.calendar_month,
                      label: "YEAR GRADUATED",
                    ),
                  ),

                  // High School
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      icon: Icons.school_outlined,
                      label: "HIGH SCHOOL",
                    ),
                  ),

                  // Year Graduated on High School
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      icon: Icons.calendar_month,
                      label: "YEAR GRADUATED",
                    ),
                  ),

                  // College
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      icon: Icons.school_outlined,
                      label: "COLLEGE",
                      hint: 'If not a transferee, please type N/A',
                    ),
                  ),

                  // Membership in School Organization
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      icon: Icons.group,
                      label: "SCHOOL ORGANIZATION",
                      hint: 'If none, please type N/A',
                    ),
                  ),

                  // Extra-curricular activities in high school
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomField(
                      readOnly: false,
                      icon: Icons.local_activity,
                      label: "EXTRA-CURRICULAR (HIGH SCHOOL)",
                      hint: 'If none, please type N/A',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
