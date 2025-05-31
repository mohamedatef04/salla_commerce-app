import 'package:dartz/dartz.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<Either<Failures, User>> signUpNewUser({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> signInUser({
    required String email,
    required String password,
  });

  Future<void> addUserData({
    required String path,
    required Map<String, dynamic> data,
  });
}
