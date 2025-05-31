import 'package:dartz/dartz.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Profile/data/models/user_model.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';

abstract class ProfileRepo {
  Future<Either<Failures, List<UserModel>>> getUserData();
  Future<Either<Failures, List<ProductModel>>> getMyOrders();
}
