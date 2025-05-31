import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/repos/home_repo.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);
  @override
  Future<Either<Failures, List<ProductModel>>> getRecommendedProducts({
    required String endpoint,
  }) async {
    try {
      final responce = await apiService.getData(endpoint: endpoint);
      List<dynamic> jsonData = responce.data;
      List<ProductModel> allProducts = [];
      List<ProductModel> recommendedProducts = [];
      for (var product in jsonData) {
        allProducts.add(ProductModel.fromJson(product));
      }

      for (var product in allProducts) {
        if (product.isRecommended == true) {
          recommendedProducts.add(product);
        }
      }
      return right(recommendedProducts);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> getLatestArrivalProducts({
    required String endpoint,
  }) async {
    try {
      final responce = await apiService.getData(endpoint: endpoint);
      List<dynamic> jsonData = responce.data;
      List<ProductModel> allProducts = [];
      List<ProductModel> latestArrivalProducts = [];
      for (var product in jsonData) {
        allProducts.add(ProductModel.fromJson(product));
      }

      for (var product in allProducts) {
        if (product.isLatestArrival == true) {
          latestArrivalProducts.add(product);
        }
      }
      return right(latestArrivalProducts);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> getallProducts({
    required String endpoint,
  }) async {
    try {
      final responce = await apiService.getData(endpoint: endpoint);
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

  @override
  Future<Either<Failures, List<ProductModel>>> getCategoryProducts({
    required String endpoint,
    required String category,
  }) async {
    try {
      final res = await apiService.getData(endpoint: endpoint);
      List<dynamic> jsonData = res.data;
      List<ProductModel> allProducts = [];
      List<ProductModel> categoryProducts = [];
      for (var product in jsonData) {
        allProducts.add(ProductModel.fromJson(product));
      }
      for (var product in allProducts) {
        if (product.category == category) {
          categoryProducts.add(product);
        } else {
          categoryProducts.remove(product);
        }
      }
      return right(categoryProducts);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
