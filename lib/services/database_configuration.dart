import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseConfiguration {
  static final SupabaseClient client = SupabaseClient(
    'https://hmzjmvuyjyzhizvsodda.supabase.co', // project database url
    'sb_publishable_WFKzntj2AHobXcaTZqM9kQ_MH38BvKf', // anon key
  );

}