import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabseService {
  final supabase = Supabase.instance.client;
  Future<void> addUerData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await supabase.from(path).insert(data);
  }
}
