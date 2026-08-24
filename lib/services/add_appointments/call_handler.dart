import 'package:guidance/database/database_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptAppointment {
  static Future<dynamic> acceptAppointment(int appointmentId) async {
    final session = await SharedPreferences.getInstance();
    final studentId = session.getInt('userId');
    try {
      await DatabaseConfiguration.client
          .from("appointments_tb")
          .update({"status": 'Accepted'})
          .eq("appointment_id", appointmentId);

      // ADD NEW SESSION RECORD

      await DatabaseConfiguration.client
        .from("session_tb")
        .insert({
          "student_id":  studentId,
          "appointment_id": appointmentId,
          "completed": false,
          "walk_in": false,
        });

      // final referral_id = await DatabaseConfiguration.client
      //   .from("appointments_tb")
      //   .select("*");
      // final response = await DatabaseConfiguration.client
      //     .from('appointments_tb')
      //     .update({'status': 'Accepted'})
      //     .eq('referral_id', id);

      return 'accepted';
    } catch (e) {
      return e;
    }
  }
}

class DeclineAppointment {
  static Future<dynamic> declineAppointment(int id, String reason) async {
    try {
      final response = await DatabaseConfiguration.client
          .from('appointments_tb')
          .update({'status': 'Declined', 'reason_for_declining': reason})
          .eq('referral_id', id);
      return 'declined';
    } catch (e) {
      return e;
    }
  }
}
