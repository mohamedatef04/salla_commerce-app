import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Search/view%20model/repos/search_repo.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';

class SearchRepoImpl implements SearchRepo {
  final ApiService apiService;

  SearchRepoImpl(this.apiService);
  @override
  Future<Either<Failures, List<ProductModel>>> searchProducts({
    required String endpoint,
    required String query,
  }) async {
    try {
      final res = await apiService.getData(endpoint: endpoint);
      List<dynamic> jsonData = res.data;
      List<ProductModel> allProducts = [];
      List<ProductModel> searchProducts = [];
      for (var product in jsonData) {
        allProducts.add(ProductModel.fromJson(product));
      }
      for (var product in allProducts) {
        if (product.name!.toLowerCase().contains(query.toLowerCase())) {
          searchProducts.add(product);
        } else {
          searchProducts.remove(product);
        }
      }

      return right(searchProducts);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
