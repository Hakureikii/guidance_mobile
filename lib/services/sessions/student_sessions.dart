import '../../database/database_configuration.dart';

class StudentSessions {
  static Future<dynamic> sessions() async {
    final session = await DatabaseConfiguration.client
        .from('session_tb')
        .select("*");
    return session;
  }
}
