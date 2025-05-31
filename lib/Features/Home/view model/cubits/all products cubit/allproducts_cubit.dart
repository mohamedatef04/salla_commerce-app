import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/repos/home_repo.dart';

part 'allproducts_state.dart';

class AllproductsCubit extends Cubit<AllproductsState> {
  AllproductsCubit(this.homeRepo) : super(AllproductsInitial());
  final HomeRepo homeRepo;

  Future<void> getAllProducts() async {
    emit(AllproductsLoading());
    final res = await homeRepo.getallProducts(endpoint: 'all_products');
    res.fold(
      (l) {
        emit(AllproductsFailure(errMessage: l.message));
      },
      (r) {
        emit(AllproductsLoaded(allproducts: r));
      },
    );
  }
}
