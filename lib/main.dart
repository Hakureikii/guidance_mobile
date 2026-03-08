import 'package:flutter/material.dart';
import 'templates/form_personal_information.dart';
import 'templates/form_family_background.dart';
import 'templates/form_educational_background.dart';
import 'templates/form_health.dart';
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
  final TextEditingController studentNoController = TextEditingController();

  int page = 0;
  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubicEmphasized,
    );
    
    if (page > 2) {
      debugPrint('Insert mo na bai');
    } else {
      page ++;
      print(page);
    }
  }

  void previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubicEmphasized,
    );
    page --;
    print(page);
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
                  studentNoController: studentNoController,
                ),
          
                FamilyBackground(
                  nextPage: nextPage,
                  previousPage: previousPage,
                ),

                EducationalBackground(
                  nextPage: nextPage, 
                  previousPage: previousPage,
                  ),

                Health(
                  nextPage: nextPage,
                  previousPage: previousPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}