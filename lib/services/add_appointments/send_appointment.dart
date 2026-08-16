import '../../database/database_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitAppointment {
  static Future<dynamic> submitAppointment(
    String? name,
    String? studentId,
    String? reasonsForReferral,
    String? about,
    String? others,
    String? prediction,
    List<dynamic>? probabilities,
  ) async {
    final session = await SharedPreferences.getInstance();
    final userId = session.getInt('userId');
    final role = session.getString('role');

    try {
      if (role == 'Student') {
        await DatabaseConfiguration.client.from('referrals_tb').insert({
          'student_id': userId,
          'reasons_for_referral': reasonsForReferral,
          'about_details': about,
          'other_details': others,
          'name_of_student': name,
          'referred_student_id': studentId,
          'prediction': prediction,
          'probabilities': probabilities
        });
      } else if (role == 'Faculty') {
        await DatabaseConfiguration.client.from('referrals_tb').insert({
          'faculty_id': userId,
          'reasons_for_referral': reasonsForReferral,
          'about_details': about,
          'other_details': others,
          'name_of_student': name,
          'referred_student_id': studentId,
          'prediction': prediction,
          'probabilities': probabilities
        });
      } else if (role == 'Parent') {
        await DatabaseConfiguration.client.from('referrals_tb').insert({
          'parent_id': userId,
          'reasons_for_referral': reasonsForReferral,
          'about_details': about,
          'other_details': others,
          'name_of_student': name,
          'referred_student_id': studentId,
          'prediction': prediction,
          'probabilities': probabilities
        });
      } else if (role == 'Guardian') {
        await DatabaseConfiguration.client.from('referrals_tb').insert({
          'guardian_id': userId,
          'reasons_for_referral': reasonsForReferral,
          'about_details': about,
          'other_details': others,
          'name_of_student': name,
          'referred_student_id': studentId,
          'prediction': prediction,
          'probabilities': probabilities
        });
      }

      return 'Success';
    } catch (e) {
      return e;
    }
  }
}
