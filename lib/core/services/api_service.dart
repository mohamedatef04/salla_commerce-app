import 'package:dio/dio.dart';
import 'package:salla_commerce_app/core/utils/constants.dart';

class ApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl:baseUrl,
      headers: {'apikey': supabaseAnonKey},
    ),
  );

  Future<Response> getData({required String endpoint}) async {
    final responce = await dio.get(endpoint);
    return responce;
  }

  Future<Response> postData({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final responce = await dio.post(endpoint, data: data);
    return responce;
  }

  Future<Response> patchData({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final responce = await dio.put(endpoint, data: data);
    return responce;
  }

  Future<Response> deleteData({required String endpoint}) async {
    final responce = await dio.delete(endpoint);
    return responce;
  }
}
