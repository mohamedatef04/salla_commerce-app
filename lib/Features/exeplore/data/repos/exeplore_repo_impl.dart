import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/exeplore/view%20model/repos/exeplore_repo.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';

class ExeploreRepoImpl implements ExeploreRepo {
  final ApiService apiService;

  ExeploreRepoImpl(this.apiService);

  @override
  Future<Either<Failures, List<ProductModel>>> getAllProducts() async {
    try {
      final responce = await apiService.getData(
        endpoint: 'all_products?select=*,favourite_products(*)',
      );
      List<dynamic> jsonData = responce.data;
      List<ProductModel> allProducts = [];

      for (var product in jsonData) {
        allProducts.add(ProductModel.fromJson(product));
      }

      return right(allProducts);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
