import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/repos/cart_repo.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartRepoImpl implements CartRepo {
  final ApiService apiService;

  CartRepoImpl(this.apiService);
  @override
  Future<void> addToCart({required ProductModel productModel}) async {
    try {
      await apiService.postData(
        endpoint: 'cart_products',
        data: {
          'is_incart': true,
          'for_user': Supabase.instance.client.auth.currentUser!.id,
          'for_product': productModel.id,
        },
      );
    } on DioException catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> getCartProducts() async {
    try {
      final res = await apiService.getData(
        endpoint: 'all_products?select=*,cart_products(*)',
      );
      List<dynamic> jsonData = res.data;
      List<ProductModel> allProducts = [];
      List<ProductModel> filterdCartProducts = [];
      for (var product in jsonData) {
        allProducts.add(ProductModel.fromJson(product));
      }

      for (var product in allProducts) {
        if (product.cartProducts!.isNotEmpty &&
            product.cartProducts!
                .where(
                  (e) =>
                      e['for_user'] ==
                      Supabase.instance.client.auth.currentUser!.id,
                )
                .isNotEmpty) {
          filterdCartProducts.add(product);
        } else {
          filterdCartProducts.remove(product);
        }
      }

      return right(filterdCartProducts);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> removeFromCart({required ProductModel productModel}) async {
    try {
      await apiService.deleteData(
        endpoint:
            'cart_products?for_user=eq.${Supabase.instance.client.auth.currentUser!.id}&for_product=eq.${productModel.id}',
      );
    } on DioException catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }
}
