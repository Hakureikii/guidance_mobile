import '../database/database_configuration.dart';

class SearchSuggestions {
  static Future <dynamic> suggestions (String? value) async {
    final names = await DatabaseConfiguration.client
    .from('student_view')
    .select('full_name, student_id')
    .ilike('full_name', '%$value%')
    .limit(5);
    return names;
  }
  
}