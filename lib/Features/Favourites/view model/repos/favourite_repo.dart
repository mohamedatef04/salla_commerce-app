import 'package:dartz/dartz.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';

abstract class FavouriteRepo {
  Future<void> addToFavourite({required ProductModel productModel});
  Future<Either<Failures, List<ProductModel>>>
  getFavouriteProducts(); //List<ProductModel>>
  Future<void> removeFromFavourite({required ProductModel productModel});
}
