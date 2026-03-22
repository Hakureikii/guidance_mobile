import '../database_configuration.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUsers {
  static Future<String> loginUsers(
    String email,
    String password,
    String role,
  ) async {
    try {
      String? login;
      
      if (role == 'Student') {
        final data = await DatabaseConfiguration.client
            .from('student_tb')
            .select('*')
            .eq('email_address', email)
            .single();

        int userId = data['student_id'];
        bool isValidated = BCrypt.checkpw(password, data['password']);
        if (isValidated == true) {

          // Shared preferences (Local Storage)
          final storage = await SharedPreferences.getInstance();
          storage.setInt('userId', userId);
          storage.setString('role', role);
          storage.setString('username', data['first_name']);
          login = 'loginStudent';
        }
      } else if (role == 'Faculty') {
        final facultydata = await DatabaseConfiguration.client
            .from('faculty_tb')
            .select('*')
            .eq('email_address', email)
            .single();

        int userId = facultydata['faculty_id'];
        bool isValidated = BCrypt.checkpw(password, facultydata['password']);
        if (isValidated == true) {
            
          // Shared preferences (Local Storage)
          final storage = await SharedPreferences.getInstance();
          storage.setInt('userId', userId);
          storage.setString('role', role);
          storage.setString('username', facultydata['first_name']);
          login = 'loginFaculty';
        }
      } else if (role == 'Parent') {
        login = 'loginParent';
      } else {
        login = 'loginGuidance';
      }
      return '$login';
    } catch (e) {
      return '$e';
    }
  }
}
