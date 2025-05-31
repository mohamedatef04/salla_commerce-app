part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartProductsLoading extends CartState {}

class CartProductsAdded extends CartState {}

class CartProductsIsEmpty extends CartState {}

class CartProductAlreadyInCart extends CartState {}

class CartProductsLoaded extends CartState {}

class CartProductsUpdatedAfterRemove extends CartState {}

class CartProductsRemoved extends CartState {}

class CartProductsFailure extends CartState {
  final String errMessage;
  CartProductsFailure({required this.errMessage});
}
