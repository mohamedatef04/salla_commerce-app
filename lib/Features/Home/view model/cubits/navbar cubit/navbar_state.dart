part of 'navbar_cubit.dart';

@immutable
abstract class NavbarState {}

class NavbarInitial extends NavbarState {}

class NavbarChanged extends NavbarState {}

class NavbarError extends NavbarState {}
