import '../database/database_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitorChildData {
  static Future<dynamic> getChildData() async {
    final localStorage = await SharedPreferences.getInstance();
    final role = localStorage.getString('role');
    final userId = localStorage.getInt('userId');

    try {
      if (role == 'Parent' || role == 'Guardian') {
        final table = role == 'Parent' ? 'parent_tb' : 'guardian_tb';
        final idColumn = role == 'Parent' ? 'parent_id' : 'guardian_id';

        final childId = await DatabaseConfiguration.client
            .from(table)
            .select('student_id')
            .eq(idColumn, userId.toString())
            .single();

        final childData = await DatabaseConfiguration.client
            .from('student_tb')
            .select(
              'first_name, last_name, middle_name, course, year, section, student_number',
            )
            .eq('student_id', childId['student_id']);
        return childData;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getChildTotalReferrals() async {
    final localStorage = await SharedPreferences.getInstance();
    final role = localStorage.getString('role');
    final userId = localStorage.getInt('userId');

    try {
      if (role == 'Parent' || role == 'Guardian') {
        final table = role == 'Parent' ? 'parent_tb' : 'guardian_tb';
        final idColumn = role == 'Parent' ? 'parent_id' : 'guardian_id';

        final child = await DatabaseConfiguration.client
            .from(table)
            .select('student_id')
            .eq(idColumn, userId.toString())
            .single();

        final childTotalReferrals = await DatabaseConfiguration.client
            .from('referrals_tb')
            .select('count')
            .eq('referred_student_id', child['student_id'])
            .count();

        return childTotalReferrals.count;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getChildAcceptedReferrals() async {
    final localStorage = await SharedPreferences.getInstance();
    final role = localStorage.getString('role');
    final userId = localStorage.getInt('userId');

    try {
      if (role == 'Parent' || role == 'Guardian') {
        final table = role == 'Parent' ? 'parent_tb' : 'guardian_tb';
        final idColumn = role == 'Parent' ? 'parent_id' : 'guardian_id';

        final child = await DatabaseConfiguration.client
            .from(table)
            .select('student_id')
            .eq(idColumn, userId.toString())
            .single();

        final childAcceptedReferrals = await DatabaseConfiguration.client
            .from('appointments_tb')
            .select('referral_id!inner(referred_student_id)')
            .eq('referral_id.referred_student_id', child['student_id'])
            .eq('status', 'Accepted')
            .count();

        return childAcceptedReferrals.count;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getChildDeclinedReferrals() async {
    final localStorage = await SharedPreferences.getInstance();
    final role = localStorage.getString('role');
    final userId = localStorage.getInt('userId');

    try {
      if (role == 'Parent' || role == 'Guardian') {
        final table = role == 'Parent' ? 'parent_tb' : 'guardian_tb';
        final idColumn = role == 'Parent' ? 'parent_id' : 'guardian_id';

        final child = await DatabaseConfiguration.client
            .from(table)
            .select('student_id')
            .eq(idColumn, userId.toString())
            .single();

        final childDeclinedReferrals = await DatabaseConfiguration.client
            .from('appointments_tb')
            .select('referral_id!inner(referred_student_id)')
            .eq('referral_id.referred_student_id', child['student_id'])
            .eq('status', 'Declined')
            .count();

        return childDeclinedReferrals.count;
      }
    } catch (e) {
      return e;
    }
  }

  static Future <dynamic> getChildCompletedSessions() async {
    final localStorage = await SharedPreferences.getInstance();
    final role = localStorage.getString('role');
    final userId = localStorage.getInt('userId');

    try {
      if (role == 'Parent' || role == 'Guardian') {
        final table = role == 'Parent' ? 'parent_tb' : 'guardian_tb';
        final idColumn = role == 'Parent' ? 'parent_id' : 'guardian_id';

        final child = await DatabaseConfiguration.client
            .from(table)
            .select('student_id')
            .eq(idColumn, userId.toString())
            .single();

        final childCompletedSessions = await DatabaseConfiguration.client
            .from('session_tb')
            .select('count')
            .eq('student_id', child['student_id'])
            .eq('completed', true)
            .count();

        return childCompletedSessions.count;
      }
    } catch (e) {
      return e;
    }
  }
}