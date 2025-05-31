part of 'categoryproducts_cubit.dart';

@immutable
abstract class CategoryproductsState {}

class CategoryproductsInitial extends CategoryproductsState {}

class CategoryproductsLoading extends CategoryproductsState {}

class CategoryproductsLoaded extends CategoryproductsState {
  final List<ProductModel> categoryproducts;
  CategoryproductsLoaded({required this.categoryproducts});
}

class CategoryproductsFailure extends CategoryproductsState {
  final String errMessage;
  CategoryproductsFailure({required this.errMessage});
}
