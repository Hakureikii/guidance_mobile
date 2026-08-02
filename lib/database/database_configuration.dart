import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseConfiguration {
  static const String supabaseUrl = 'https://hmzjmvuyjyzhizvsodda.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_WFKzntj2AHobXcaTZqM9kQ_MH38BvKf';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://hmzjmvuyjyzhizvsodda.supabase.co',
      anonKey: 'sb_publishable_WFKzntj2AHobXcaTZqM9kQ_MH38BvKf'
    );
  }

  // static const String supabaseUrl = ;
  // static const String supabaseAnonKey = ;

  // static Future<void> initialize() async {
  //   await Supabase.initialize(
  //     url:
  //     anonKey:
  //   );
  // }

  static SupabaseClient get client => Supabase.instance.client;
}
