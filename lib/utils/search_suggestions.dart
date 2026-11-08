import '../database/database_configuration.dart';

class SearchSuggestions {
  static Future <dynamic> suggestions (String? value) async {
    final backgroundData = await DatabaseConfiguration.client
    .from('student_background_data_analysis')
    .select('*')
    .ilike('full_name', '%$value%')
    .limit(5);
    return backgroundData;
  }
  
}