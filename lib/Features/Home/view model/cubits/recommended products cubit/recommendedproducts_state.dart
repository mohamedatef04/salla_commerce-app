part of 'recommendedproducts_cubit.dart';

@immutable
abstract class RecommendedproductsState {}

class RecommendedproductsInitial extends RecommendedproductsState {}

class RecommendedproductsLoading extends RecommendedproductsState {}

class RecommendedproductsLoaded extends RecommendedproductsState {
  final List<ProductModel> recommendedproducts;
  RecommendedproductsLoaded({required this.recommendedproducts});
}

class RecommendedproductsFailure extends RecommendedproductsState {
  final String errMessage;
  RecommendedproductsFailure({required this.errMessage});
}
