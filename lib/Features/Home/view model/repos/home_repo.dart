import 'package:dartz/dartz.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';

abstract class HomeRepo {
  Future<Either<Failures, List<ProductModel>>> getCategoryProducts({
    required String endpoint,
    required String category,
  });
  Future<Either<Failures, List<ProductModel>>> getallProducts({
    required String endpoint,
  });
  Future<Either<Failures, List<ProductModel>>> getRecommendedProducts({
    required String endpoint,
  });
  Future<Either<Failures, List<ProductModel>>> getLatestArrivalProducts({
    required String endpoint,
  });
}
