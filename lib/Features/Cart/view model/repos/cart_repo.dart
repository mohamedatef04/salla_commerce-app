import 'package:dartz/dartz.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';

abstract class CartRepo {
  Future<void> addToCart({required ProductModel productModel});
  Future<Either<Failures, List<ProductModel>>> getCartProducts();

  Future<void> removeFromCart({required ProductModel productModel});
}
