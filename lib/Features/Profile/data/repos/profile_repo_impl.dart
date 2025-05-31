import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Profile/data/models/user_model.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/repos/profile_repo.dart';
import 'package:salla_commerce_app/core/errors/errors.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';
import 'package:salla_commerce_app/core/services/supabase_databse_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepoImpl implements ProfileRepo {
  final SupabaseDatabseService supabaseDatabseService;
  final ApiService apiService;

  ProfileRepoImpl(this.supabaseDatabseService, this.apiService);

  @override
  Future<Either<Failures, List<UserModel>>> getUserData() async {
    try {
      final res = await apiService.getData(endpoint: 'users');

      List<dynamic> data = res.data;
      List<UserModel> allusers = [];
      List<UserModel> filteredUsers = [];
      for (var user in data) {
        allusers.add(UserModel.fromJson(user));
      }
      if (allusers
          .where((e) => e.id == Supabase.instance.client.auth.currentUser!.id)
          .isNotEmpty) {
        filteredUsers.add(
          allusers
              .where(
                (e) => e.id == Supabase.instance.client.auth.currentUser!.id,
              )
              .first,
        );
      }
      print(filteredUsers);
      return right(filteredUsers);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> getMyOrders() async {
    try {
      final res = await apiService.getData(
        endpoint: 'all_products?select=*,purchased_products(*)',
      );
      List<dynamic> jsonData = res.data;
      List<ProductModel> allOrders = [];
      List<ProductModel> filteredOrders = [];
      for (var product in jsonData) {
        allOrders.add(ProductModel.fromJson(product));
      }
      for (var product in allOrders) {
        if (product.orders!.isNotEmpty &&
            product.orders!
                .where(
                  (e) =>
                      e['for_user'] ==
                      Supabase.instance.client.auth.currentUser!.id,
                )
                .isNotEmpty) {
          filteredOrders.add(product);
        }
      }
      return right(filteredOrders);
    } on DioException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
