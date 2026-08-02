// import 'package:supabase_flutter/supabase_flutter.dart';
import '../../database/database_configuration.dart';
import 'package:flutter/material.dart';

class InsertDataInventory {
  static Future<int?> insertStudent({
    String? studentNo,
    String? firstName,
    String? middleName,
    String? lastName,
    String? nickname,
    String? course,
    String? year,
    String? section,
    String? age,
    String? placeOfBirth,
    String? dateOfBirth,
    String? gender,
    String? emailAddress,
  }) async {
    try {
      final response = await DatabaseConfiguration.client
          .from('student_tb')
          .insert({
            'student_number': studentNo,
            'nickname': nickname,
            'first_name': firstName,
            'middle_name': middleName,
            'last_name': lastName,
            'course': course,
            'year': year,
            'section': section,
            'age': age,
            'place_of_birth': placeOfBirth,
            'date_of_birth': dateOfBirth,
            'gender': gender,
            'email_address': emailAddress,
          })
          .select()
          .single();
      int studentId = response['student_id'];
      debugPrint("Inserted Data");
      return studentId;
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  static Future<void> insertCivilStatus({
    int? studentId,
    String? civilStatus,
    String? spouseName,
    String? spouseContactNumber,
  }) async {
    try {
      if (civilStatus == 'Single') {
        spouseName = 'N/A';
        spouseContactNumber = 'N/A';
      }

      await DatabaseConfiguration.client
          .from('student_civil_status_tb')
          .insert({
            'student_id': studentId,
            'civil_status': civilStatus,
            'name_of_spouse': spouseName,
            'contact_no_of_spouse': spouseContactNumber,
          });
      debugPrint("Inserted Data");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  static Future<void> insertContact({
    int? studentId,
    String? presentAddress,
    String? phoneNumber,
    String? provincialAddress,
    String? homePhoneNumber,
    String? ethnicGroup,
    String? livingArrangement,
  }) async {
    try {

      if (ethnicGroup == 'No') {
        ethnicGroup == 'N/A';
      }
      
      await DatabaseConfiguration.client
      .from('student_contact_tb')
      .insert({
        'student_id': studentId,
        'present_address': presentAddress,
        'phone_number': phoneNumber,
        'provincial_address': provincialAddress,
        'home_phone_number': homePhoneNumber,
        'ethnic_group': ethnicGroup,
        'living_arrangement': livingArrangement,
      });
    }catch (e) {
      debugPrint("Error $e");
    } 
  }

  static Future<void> insertMother({
    int? studentId,
    String? lastName,
    String? firstName,
    String? middleName,
    String? age,
    String? address,
    String? contactNumber,
    String? sourceOfIncome,
    String? estimatedAnnualIncome,
    String? occupation,
  }) async {
    try {
      await DatabaseConfiguration.client
      .from('parent_tb')
      .insert({
        'student_id': studentId,
        'last_name': lastName,
        'first_name': firstName,
        'middle_name': middleName,
        'age': age,
        'address': address,
        'contact_number': contactNumber,
        'sources_of_income': sourceOfIncome,
        'is_mother': 'TRUE',
        'estimated_annual_income': estimatedAnnualIncome,
        'occupation': occupation,
      });
    }
    catch (e) {
      debugPrint("Error $e");
    }
  }

  static Future<void> insertFather({
    int? studentId,
    String? lastName,
    String? firstName,
    String? middleName,
    String? age,
    String? address,
    String? contactNumber,
    String? sourceOfIncome,
    String? estimatedAnnualIncome,
    String? occupation,
  }) async {
    try {
      await DatabaseConfiguration.client
      .from('parent_tb')
      .insert({
        'student_id': studentId,
        'last_name': lastName,
        'first_name': firstName,
        'middle_name': middleName,
        'age': age,
        'address': address,
        'contact_number': contactNumber,
        'sources_of_income': sourceOfIncome,
        'is_mother': 'FALSE',
        'estimated_annual_income': estimatedAnnualIncome,
        'occupation': occupation,
      });
    }
    catch (e) {
      debugPrint("Error $e");
    }
  }

  static Future<void> insertGuardian({
    int? studentId,
    String? lastName,
    String? firstName,
    String? middleName,
    String? age,
    String? address,
    String? contactNumber,
    String? sourceOfIncome,
    String? estimatedAnnualIncome,
    String? occupation,
  }) async {
    try {
      await DatabaseConfiguration.client
      .from('guardian_tb')
      .insert({
        'student_id': studentId,
        'last_name': lastName,
        'first_name': firstName,
        'middle_name': middleName,
        'age': age,
        'address': address,
        'contact_number': contactNumber,
        'sources_of_income': sourceOfIncome,
        'estimated_annual_income': estimatedAnnualIncome,
        'occupation': occupation,
      });
    }
    catch (e) {
      debugPrint("Error $e");
    }
  }

  static Future<void> insertSiblings({
    int? studentId,
    required List<Map<String, TextEditingController>> siblings,
  }) async {
    try {

      for (var sibling in siblings) {
        await DatabaseConfiguration.client
        .from('siblings_tb')
        .insert({
          'student_id': studentId,
          'last_name': sibling["LastName"]!.text,
          'first_name': sibling["FirstName"]!.text,
          'middle_name': sibling["MiddleName"]!.text,
          'age': sibling["Age"]!.text,
          'school_or_occupation': sibling["Occupation"]!.text,
        });
      }
    }
    catch (e) {
      debugPrint("Error $e");
    }
  }

  static Future<void> insertEducationalBackground({
    int? studentId,
    String? elementarySchool,
    String? elementaryYearGraduated,
    String? highSchool,
    String? highschoolYearGraduated,
    String? collegeSchool,
    String? schoolOrganization,
    String? extraCurricularActivities,

  }) async {
    try {
        await DatabaseConfiguration.client
        .from('student_educational_background_tb')
        .insert({
          'student_id': studentId,
          'elementary': elementarySchool,
          'elementary_yr_graduated': elementaryYearGraduated,
          'high_school': highSchool,
          'highschool_yr_graduated': highschoolYearGraduated,
          'college': collegeSchool,
          'membership_in_organization': schoolOrganization,
          'extra_curricular_activities': extraCurricularActivities,
        });
      
    }
    catch (e) {
      debugPrint("Error $e");
    }
  }

  static Future<String?> insertHealth({
    int? studentId,
    String? healthCondition,
    String? notGoodCondition,
    String? disabilities,

  }) async {
    try {

      if (healthCondition == 'Good') {
        notGoodCondition = 'N/A';
      }

        await DatabaseConfiguration.client
        .from('student_health_tb')
        .insert({
          'student_id': studentId,
          'general_condition_of_health': healthCondition,
          'physical_disabilities': disabilities,
          'health_reason': notGoodCondition,
        });

        return 'Success';
      
    }
    catch (e) {
      return e.toString();
    }
  }
}
