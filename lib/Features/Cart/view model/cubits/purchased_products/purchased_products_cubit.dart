import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/repos/purchased_products_repo.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';

part 'purchased_products_state.dart';

class PurchasedProductsCubit extends Cubit<PurchasedProductsState> {
  PurchasedProductsCubit(this.purchasedProductsRepo)
    : super(PurchasedProductsInitial());

  final PurchasedProductsRepo purchasedProductsRepo;

  Future<void> addPurchasedProducts({
    required ProductModel productModel,
  }) async {
    emit(PurchasedProductsLoading());
    try {
      await purchasedProductsRepo.addToPurchased(productModel: productModel);
      emit(PurchasedProductsAdded());
    } on Exception catch (e) {
      emit(PurchasedProductsFailure(errMessage: e.toString()));
    }
  }
}
