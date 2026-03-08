import '../database_configuration.dart';
import 'package:flutter/material.dart';

class InsertDataInventory {
  static Future<void> insertStudent(
    String? firstName,
    String? middleName,
    String? lastName,
    
  ) async {
    try {
      await DatabaseConfiguration.client.from('student_tb').insert({
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
      });
      debugPrint("Inserted Data");

    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
