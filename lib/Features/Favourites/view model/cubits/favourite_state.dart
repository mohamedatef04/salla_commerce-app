part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteAdded extends FavouriteState {}

class EmptyFavouriteProducts extends FavouriteState {}

class FavouriteRemoved extends FavouriteState {}

class FavouriteProductAlreadyInFavourites extends FavouriteState {}

class FavouriteUpdatedAfterRemove extends FavouriteState {
  final List<ProductModel> favouriteProductsAfterRemove;
  FavouriteUpdatedAfterRemove({required this.favouriteProductsAfterRemove});
}

class FavouriteLoaded extends FavouriteState {}

class FavouriteFailure extends FavouriteState {
  final String errMessage;
  FavouriteFailure({required this.errMessage});
}
