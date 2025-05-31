part of 'userdata_cubit.dart';

@immutable
abstract class UserdataState {}

class UserdataInitial extends UserdataState {}

class UserdataLoading extends UserdataState {}

class UserdataSuccess extends UserdataState {
  final List<UserModel> userData;
  UserdataSuccess({required this.userData});
}

class UserdataFailure extends UserdataState {
  final String message;
  UserdataFailure({required this.message});
}
