import 'package:shared_preferences/shared_preferences.dart';

import '../../database/database_configuration.dart';
import '../../services/auth/sessions.dart';

class StudentSessions {
  static Future<dynamic> sessions() async {
    final localStorage = await SharedPreferences.getInstance();
    final studentId = localStorage.getInt('userId');

    final session = await DatabaseConfiguration.client
        .from('appointments_tb')
        .select('''
          referral_id!inner(
            reasons_for_referral,
            about_details,
            other_details,
            prediction,
            probabilities,

            referral_student:student_tb!referrals_tb_referred_student_id_fkey(
              student_number,
              last_name,
              first_name,
              middle_name,
              course
            ),

            referring_student:student_tb!referrals_tb_student_id_fkey(
              first_name,
              last_name
            ),

            faculty_tb!faculty_id(
              first_name,
              last_name
            ),

            parent_tb!parent_id(
              first_name,
              last_name
            ),

            guardian_tb!guardian_id(
              first_name,
              last_name
            )
          ),

          appointment_date,
          time,
          status,
          purpose,

          guidance_counselor_id!inner(
            first_name
          )
          ''')
        .eq('referral_id.referred_student_id', studentId.toString());

    return session;
  }
}
