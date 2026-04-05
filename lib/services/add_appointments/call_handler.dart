import 'package:guidance/services/database_configuration.dart';

class AcceptAppointment {
  static Future<dynamic> acceptAppointment(int id) async {
    try {
      final response = await DatabaseConfiguration.client
          .from('appointments_tb')
          .update({'status': 'Accepted'})
          .eq('referral_id', id);
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
          .update({
            'status': 'Declined',
            'reason_for_declining': reason
            })
          .eq('referral_id', id);
      return 'declined';
    } catch (e) {
      return e;
    }
  }
}
