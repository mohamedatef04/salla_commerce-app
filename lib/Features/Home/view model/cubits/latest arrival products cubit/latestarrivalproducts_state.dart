part of 'latestarrivalproducts_cubit.dart';

@immutable
abstract class LatestarrivalproductsState {}

class LatestarrivalproductsInitial extends LatestarrivalproductsState {}

class LatestarrivalproductsLoading extends LatestarrivalproductsState {}

class LatestarrivalproductsLoaded extends LatestarrivalproductsState {
  final List<ProductModel> latestarrivalproducts;
  LatestarrivalproductsLoaded({required this.latestarrivalproducts});
}

class LatestarrivalproductsFailure extends LatestarrivalproductsState {
  final String errMessage;
  LatestarrivalproductsFailure({required this.errMessage});
}
