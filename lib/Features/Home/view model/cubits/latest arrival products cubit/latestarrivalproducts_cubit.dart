import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/repos/home_repo.dart';

part 'latestarrivalproducts_state.dart';

class LatestarrivalproductsCubit extends Cubit<LatestarrivalproductsState> {
  LatestarrivalproductsCubit(this.homeRepo)
    : super(LatestarrivalproductsInitial());
  final HomeRepo homeRepo;
  Future<void> getLatestArrivalProducts() async {
    emit(LatestarrivalproductsLoading());
    final res = await homeRepo.getLatestArrivalProducts(
      endpoint: 'all_products?select=*,favourite_products(*)',
    );
    res.fold(
      (l) {
        emit(LatestarrivalproductsFailure(errMessage: l.message));
      },
      (r) {
        emit(LatestarrivalproductsLoaded(latestarrivalproducts: r));
      },
    );
  }
}
