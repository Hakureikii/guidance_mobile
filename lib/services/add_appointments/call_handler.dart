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

      await DatabaseConfiguration.client.from("session_tb").insert({
        "student_id": studentId,
        "remarks": null,
        "appointment_id": appointmentId,
        "completed": false,
        "walk_in": false,
      });

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

      // ADD PREFERED TIME

      return 'declined';
    } catch (e) {
      return e;
    }
  }
}
