import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/repos/home_repo.dart';

part 'recommendedproducts_state.dart';

class RecommendedproductsCubit extends Cubit<RecommendedproductsState> {
  RecommendedproductsCubit(this.homeRepo) : super(RecommendedproductsInitial());

  final HomeRepo homeRepo;

  Future<void> getRecommendedProducts() async {
    emit(RecommendedproductsLoading());
    final res = await homeRepo.getRecommendedProducts(
      endpoint: 'all_products?select=*,favourite_products(*)',
    );
    res.fold(
      (l) {
        emit(RecommendedproductsFailure(errMessage: l.message));
      },
      (r) {
        emit(RecommendedproductsLoaded(recommendedproducts: r));
      },
    );
  }
}
