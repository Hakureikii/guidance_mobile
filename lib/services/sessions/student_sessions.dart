import 'package:shared_preferences/shared_preferences.dart';

import '../../database/database_configuration.dart';
import '../../services/auth/sessions.dart';

class StudentSessions {
  static Future<dynamic> sessions() async {
    final localStorage = await SharedPreferences.getInstance();
    final studentId = localStorage.getInt('userId');
    final session = await DatabaseConfiguration.client
        .from('appointments_tb')
        .select(
          "referral_id!inner(referred_student_id), appointment_date, time, status, purpose, guidance_counselor_id!inner(first_name))",
        )
        .eq('referral_id.referred_student_id', studentId.toString());
    return session;
  }
}
