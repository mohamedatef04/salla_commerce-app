import 'package:dio/dio.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/repos/purchased_products_repo.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PurchasedProductsRepoImpl implements PurchasedProductsRepo {
  final ApiService apiService;

  PurchasedProductsRepoImpl({required this.apiService});
  @override
  Future<void> addToPurchased({required ProductModel productModel}) async {
    try {
      await apiService.postData(
        endpoint: 'purchased_products',
        data: {
          'is_purchased': true,
          'for_user': Supabase.instance.client.auth.currentUser!.id,
          'for_product': productModel.id,
        },
      );
    } on DioException catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }
}
