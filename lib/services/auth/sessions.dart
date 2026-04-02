import 'package:shared_preferences/shared_preferences.dart';

class Sessions {

  static Future<dynamic> validate() async {
    final sessions = await SharedPreferences.getInstance();
    final username = sessions.getString('username');
    final role = sessions.getString('role');
    final userId = sessions.getInt('userId');

    if (username == null && role == null && userId == null) {
      return 'no session';
    }
    
    if (role == 'Student') {
      return 'Student';
    }

    if (role == 'Faculty') {
      return 'Faculty';
    }

    if (role == 'Guardian') {
      return 'Guardian';
    }

    if (role == 'Parent') {
      return 'Parent';
    }

    return null;
  }

  static Future<dynamic> username() async {
    final sessions = await SharedPreferences.getInstance();
    final username = sessions.getString('username');
    return username;
  }

  static Future<dynamic> userId() async {
    final sessions = await SharedPreferences.getInstance();
    final userId = sessions.getInt('userId');
    return userId;
  }

  static Future<dynamic> role() async {
    final sessions = await SharedPreferences.getInstance();
    final role = sessions.getString('role');
    return role;
  }
  
}