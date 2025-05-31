import 'package:salla_commerce_app/core/errors/custom_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<User> signUpNewUser({
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabase.auth.signUp(email: email, password: password);
      return res.user!;
    } on AuthException catch (e) {
      throw CustomException(errorMessage: e.message);
    } catch (e) {
      throw CustomException(errorMessage: 'something went wrong');
    }
  }

  Future<User> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return res.user!;
    } on AuthException catch (e) {
      throw CustomException(errorMessage: e.message);
    } catch (e) {
      throw CustomException(errorMessage: 'something went wrong');
    }
  }

  Future<bool> isSignedIn() async {
    if (supabase.auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
