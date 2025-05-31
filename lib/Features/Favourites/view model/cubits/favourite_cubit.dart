import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Favourites/view%20model/repos/favourite_repo.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.favouriteRepo) : super(FavouriteInitial());
  final FavouriteRepo favouriteRepo;
  late List<ProductModel> favouriteProducts;

  Future<void> addToFavourite({required ProductModel productModel}) async {
    emit(FavouriteLoading());

    try {
      final res = await favouriteRepo.getFavouriteProducts();
      res.fold(
        (l) {
          emit(FavouriteFailure(errMessage: l.message));
        },
        (r) async {
          if (r.where((e) => e.id == productModel.id).isEmpty) {
            await favouriteRepo.addToFavourite(productModel: productModel);
            emit(FavouriteAdded());
          } else {
            emit(FavouriteProductAlreadyInFavourites());
          }
        },
      );
    } on Exception catch (e) {
      emit(FavouriteFailure(errMessage: e.toString()));
    }
  }

  Future<void> getFavouriteProducts() async {
    emit(FavouriteLoading());
    final res = await favouriteRepo.getFavouriteProducts();
    res.fold(
      (l) {
        emit(FavouriteFailure(errMessage: l.message));
      },
      (r) {
        favouriteProducts = r;
        if (favouriteProducts.isEmpty) {
          emit(EmptyFavouriteProducts());
        } else {
          emit(FavouriteLoaded());
        }
      },
    );
  }

  Future<void> removeFromFavourites({
    required ProductModel productModel,
  }) async {
    try {
      await favouriteRepo.removeFromFavourite(productModel: productModel);
      emit(FavouriteRemoved());

      final res = await favouriteRepo.getFavouriteProducts();
      res.fold(
        (l) {
          emit(FavouriteFailure(errMessage: l.message));
        },
        (r) {
          if (r.isEmpty) {
            emit(EmptyFavouriteProducts());
          } else {
            emit(FavouriteUpdatedAfterRemove(favouriteProductsAfterRemove: r));
          }
        },
      );
    } on Exception catch (e) {
      emit(FavouriteFailure(errMessage: e.toString()));
    }
  }
}
