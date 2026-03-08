// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SamplePageForms(),
//       )
//     );
// }

// class SamplePageForms extends StatefulWidget {
//   const SamplePageForms({super.key});

//   @override
//   State<SamplePageForms> createState() => _SamplePageFormsState();
// }

// class _SamplePageFormsState extends State<SamplePageForms> {
//   final PageController _pageController = PageController();

//   final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
//     padding: EdgeInsets.all(10),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadiusGeometry.all(Radius.circular(5))
//     ),
//   );

//   void nextPage() {
//     _pageController.nextPage(
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   void previousPage() {
//     _pageController.previousPage(
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [

//                 ElevatedButton.icon(
//                   label: Text('Previous'),
//                   style: _buttonStyle,
//                   onPressed: previousPage,
//                   icon: Icon(Icons.arrow_back),
//                 ),

//                 ElevatedButton.icon(
//                   label: Text('Next'),
//                   style: _buttonStyle,
//                   onPressed: nextPage, 
//                   icon: Icon(Icons.arrow_forward),
//                   ),

                
//               ],
//             ),
//           ),

//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 PersonalInformationForm(), 
//                 EducationalBackground(),
//                 FamilyBackground(),
//                 ],
//             ),
//           ),

//         ],
//       ),
//     );
//   }
// }

// class PersonalInformationForm extends StatelessWidget {
//   const PersonalInformationForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(decoration: InputDecoration(labelText: 'Personal Info Fields')),
//       ],
//     );
//   }
// }

// class EducationalBackground extends StatefulWidget {
//   const EducationalBackground({super.key});

//   @override
//   State<EducationalBackground> createState() => _EducationalBackgroundState();
// }

// class _EducationalBackgroundState extends State<EducationalBackground> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Educational Background Fields'),
//         ),
//       ],
//     );
//   }
// }

// class FamilyBackground extends StatefulWidget {
//   const FamilyBackground({super.key});

//   @override
//   State<FamilyBackground> createState() => _FamilyBackgroundState();
// }

// class _FamilyBackgroundState extends State<FamilyBackground> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Family Background Fields',
//           ),
//         )
//       ],
//     );
//   }
// }
