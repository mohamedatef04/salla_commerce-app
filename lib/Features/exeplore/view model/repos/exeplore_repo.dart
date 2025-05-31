import 'package:dartz/dartz.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';

abstract class ExeploreRepo {
  Future<Either<Failures, List<ProductModel>>> getAllProducts();
}
