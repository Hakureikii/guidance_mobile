import 'package:flutter/material.dart';

class EducationalBackground extends StatefulWidget {
  const EducationalBackground({super.key});

  @override
  State<EducationalBackground> createState() => _EducationalBackgroundState();
}

class _EducationalBackgroundState extends State<EducationalBackground> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),

        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.9,

        child: SingleChildScrollView(child: Column(children: [
              
            ],
          )),
      ),
    );
  }
}