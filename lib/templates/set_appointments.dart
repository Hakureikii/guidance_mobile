import 'package:flutter/material.dart';
import 'package:guidance/custom_widgets/page/set_appointments_page.dart';


class SetAppointments extends StatefulWidget {
  const SetAppointments({super.key});

  @override
  State<SetAppointments> createState() => SetAppointmentsState();
}

class SetAppointmentsState extends State<SetAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SetAppointmentsPage(),
    );
  }
}