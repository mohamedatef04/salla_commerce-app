import 'package:dartz/dartz.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:salla_commerce_app/Features/Auth/view%20model/repos/auth_repo.dart';
import 'package:salla_commerce_app/core/errors/custom_exception.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:salla_commerce_app/core/services/auth_service.dart';
import 'package:salla_commerce_app/core/services/supabase_databse_service.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;
  final SupabaseDatabseService supabaseDatabseService;
  AuthRepoImpl(this.authService, this.supabaseDatabseService);
  @override
  Future<Either<Failures, User>> signUpNewUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await authService.signUpNewUser(
        email: email,
        password: password,
      );
      addUserData(path: 'users', data: {'name': name, 'email': email});
      return right(res);
    } on CustomException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, User>> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final res = await authService.signInUser(
        email: email,
        password: password,
      );
      return right(res);
    } on CustomException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> addUserData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await supabaseDatabseService.addUerData(path: path, data: data);
  }
}
