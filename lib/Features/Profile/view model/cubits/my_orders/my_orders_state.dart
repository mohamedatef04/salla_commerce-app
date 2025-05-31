part of 'my_orders_cubit.dart';

@immutable
abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {}

class MyOrdersEmpty extends MyOrdersState {}

class MyOrdersLoaded extends MyOrdersState {
  final List<ProductModel> myOrders;
  MyOrdersLoaded({required this.myOrders});
}

class MyOrdersFailure extends MyOrdersState {
  final String errorMessage;
  MyOrdersFailure({required this.errorMessage});
}
