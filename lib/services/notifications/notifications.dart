import 'package:shared_preferences/shared_preferences.dart';
import '../../database/database_configuration.dart';

class Notifications {
  static Future<dynamic> studentNotifications() async {
    final session = await SharedPreferences.getInstance();
    final userId = session.getInt('userId');
    try {
      final notif = await DatabaseConfiguration.client
          .from('appointments_tb')
          .select(
            '*, referral_id!inner(referred_student_id, referral_id), is_read',
          )
          .eq('is_read', false)
          .eq('referral_id.referred_student_id', '$userId');
      return notif;
    } catch (e) {
      return e;
    }
  }
}
