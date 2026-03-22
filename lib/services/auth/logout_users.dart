import 'package:shared_preferences/shared_preferences.dart';

class LogoutUsers {
  static Future<String?> logout() async {
    final storage = await SharedPreferences.getInstance();
    await storage.clear();

    return 'session_clear';
  }
}
