part of 'exeplore_cubit.dart';

@immutable
abstract class ExeploreState {}

class ExeploreInitial extends ExeploreState {}

class ExeploreProductsLoading extends ExeploreState {}

class ExeploreProductsLoaded extends ExeploreState {
  final List<ProductModel> allProducts;

  ExeploreProductsLoaded({required this.allProducts});
}

class ExeploreProductsFailure extends ExeploreState {
  final String errMessage;

  ExeploreProductsFailure({required this.errMessage});
}
