import 'package:shared_preferences/shared_preferences.dart';
import '../database/database_configuration.dart';

class CounselingSessions {
  static Future<dynamic> sessions() async {
    final storage = await SharedPreferences.getInstance();
    final userId = storage.getInt('userId');

    if (userId == null) {
      return null;
    }

    final session = await DatabaseConfiguration.client
        .from('session_tb')
        .select('*')
        .eq('student_id', userId);

    return session;
  }
}
