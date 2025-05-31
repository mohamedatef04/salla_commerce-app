import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/repos/home_repo.dart';

part 'categoryproducts_state.dart';

class CategoryproductsCubit extends Cubit<CategoryproductsState> {
  CategoryproductsCubit(this.homeRepo) : super(CategoryproductsInitial());
  final HomeRepo homeRepo;

  Future<void> getCategoryProducts({required String category}) async {
    emit(CategoryproductsLoading());
    final res = await homeRepo.getCategoryProducts(
      endpoint: 'all_products?select=*,favourite_products(*)',
      category: category,
    );
    res.fold(
      (l) {
        emit(CategoryproductsFailure(errMessage: l.message));
      },
      (r) {
        emit(CategoryproductsLoaded(categoryproducts: r));
      },
    );
  }
}
