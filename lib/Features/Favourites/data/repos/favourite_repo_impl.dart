import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:salla_commerce_app/Features/Favourites/view%20model/repos/favourite_repo.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavouriteRepoImpl implements FavouriteRepo {
  final ApiService apiService;

  FavouriteRepoImpl({required this.apiService});

  @override
  Future<void> addToFavourite({required ProductModel productModel}) async {
    try {
      await apiService.postData(
        endpoint: 'favourite_products',
        data: {
          'is_favourite': true,
          'for_user': Supabase.instance.client.auth.currentUser!.id,
          'for_product': productModel.id,
        },
      );
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> getFavouriteProducts() async {
    try {
      final res = await apiService.getData(
        endpoint: 'all_products?select=*,favourite_products(*)',
      );
      List<dynamic> jsonData = res.data;
      List<ProductModel> allFavouriteProducts = [];
      List<ProductModel> filteredFavouriteProducts = [];

      for (var product in jsonData) {
        allFavouriteProducts.add(ProductModel.fromJson(product));
      }
      for (var product in allFavouriteProducts) {
        if (product.favouriteProducts!.isNotEmpty &&
            product.favouriteProducts!
                .where(
                  (e) =>
                      e['for_user'] ==
                      Supabase.instance.client.auth.currentUser!.id,
                )
                .isNotEmpty) {
          filteredFavouriteProducts.add(product);
        }
      }
      return right(filteredFavouriteProducts);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> removeFromFavourite({required ProductModel productModel}) async {
    try {
      await apiService.deleteData(
        endpoint:
            'favourite_products?for_user=eq.${Supabase.instance.client.auth.currentUser!.id}&for_product=eq.${productModel.id}',
      );
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
