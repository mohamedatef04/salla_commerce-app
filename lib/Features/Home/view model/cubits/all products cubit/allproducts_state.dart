part of 'allproducts_cubit.dart';

@immutable
abstract class AllproductsState {}

class AllproductsInitial extends AllproductsState {}

class AllproductsLoading extends AllproductsState {}

class AllproductsLoaded extends AllproductsState {
  final List<ProductModel> allproducts;
  AllproductsLoaded({required this.allproducts});
}

class AllproductsFailure extends AllproductsState {
  final String errMessage;
  AllproductsFailure({required this.errMessage});
}
