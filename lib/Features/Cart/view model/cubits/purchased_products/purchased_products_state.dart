part of 'purchased_products_cubit.dart';

@immutable
abstract class PurchasedProductsState {}

class PurchasedProductsInitial extends PurchasedProductsState {}

class PurchasedProductsAdded extends PurchasedProductsState {}

class PurchasedProductsLoading extends PurchasedProductsState {}

class PurchasedProductsFailure extends PurchasedProductsState {
  final String errMessage;

  PurchasedProductsFailure({required this.errMessage});
}
