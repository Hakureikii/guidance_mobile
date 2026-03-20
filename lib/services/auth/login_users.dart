import '../database_configuration.dart';
import 'package:bcrypt/bcrypt.dart';

class LoginUsers {
  static Future<bool> loginUsers(String email, String password) async {
    try {
      final data = await DatabaseConfiguration.client
          .from('student_tb')
          .select('*')
          .eq('email_address', email)
          .single();

      bool isValidated = BCrypt.checkpw(password, data['password']);
      if (isValidated) {
        return true;
      }

    } catch (e) {
      print('Error: $e');
      return false;
    }
    return false;
  }
}
