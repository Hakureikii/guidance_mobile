import 'package:guidance/database/database_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Analytics {
  static Future<dynamic> referralSent() async {
    final session = await SharedPreferences.getInstance();
    final role = session.getString('role');
    final userId = session.getInt('userId');

    if (role == 'Student') {
      final count = await DatabaseConfiguration.client
          .from('referrals_tb')
          .select('*')
          .eq('student_id', userId.toString())
          .count();
      return count.count;
    }

    if (role == 'Faculty') {
      final count = await DatabaseConfiguration.client
          .from('referrals_tb')
          .select('count')
          .eq('faculty_id', userId.toString())
          .count();
      return count.count;
    }

    if (role == 'Parent') {
      final count = await DatabaseConfiguration.client
          .from('referrals_tb')
          .select('count')
          .eq('parent_id', userId.toString())
          .count();
      return count.count;
    }
  }

  static Future<dynamic> upcomingSessions() async {
    final session = await SharedPreferences.getInstance();
    final int? userId = session.getInt('userId');

    // return userId;
    if (userId == null) {
      return null;
    }

    final count = await DatabaseConfiguration.client
        .from('appointments_tb')
        .select('referral_id!inner(referred_student_id)')
        .eq('referral_id.referred_student_id', userId.toString())
        .eq('status', 'Accepted')
        .count();
    return count.count;
  }

  // COUNT ACCOMPLISHED SESSIONS

  static Future<dynamic> sessionsDone() async {
    await DatabaseConfiguration.client.from('').select('');
  }
}
