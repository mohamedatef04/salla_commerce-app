import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/repos/cart_repo.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial());
  final CartRepo cartRepo;
  List<ProductModel>? cartProducts;

  Future<void> addToCart({required ProductModel productModel}) async {
    emit(CartProductsLoading());
    try {
      final res = await cartRepo.getCartProducts();
      res.fold(
        (l) {
          emit(CartProductsFailure(errMessage: l.message));
        },
        (r) async {
          if (r.where((e) => e.id == productModel.id).isEmpty) {
            await cartRepo.addToCart(productModel: productModel);
            emit(CartProductsAdded());
          } else {
            emit(CartProductAlreadyInCart());
          }
        },
      );
    } on Exception catch (e) {
      emit(CartProductsFailure(errMessage: e.toString()));
    }
  }

  Future<void> getCartProducts() async {
    emit(CartProductsLoading());
    final res = await cartRepo.getCartProducts();
    res.fold(
      (l) {
        emit(CartProductsFailure(errMessage: l.message));
      },
      (r) {
        cartProducts = r;
        if (cartProducts!.isEmpty) {
          emit(CartProductsIsEmpty());
        } else {
          emit(CartProductsLoaded());
        }
      },
    );
  }

  Future<void> removeFromCart({required ProductModel productModel}) async {
    emit(CartProductsLoading());

    try {
      await cartRepo.removeFromCart(productModel: productModel);

      emit(CartProductsRemoved());
      final res = await cartRepo.getCartProducts();
      res.fold(
        (l) {
          emit(CartProductsFailure(errMessage: l.message));
        },
        (r) {
          cartProducts = r;
          if (r.isEmpty) {
            emit(CartProductsIsEmpty());
          } else {
            emit(CartProductsUpdatedAfterRemove());
          }
        },
      );
    } on Exception catch (e) {
      emit(CartProductsFailure(errMessage: e.toString()));
    }
  }

  calculatetotalPrice() {
    double total = 0;
    for (var element in cartProducts ?? []) {
      total = total + element.calculateTotalPriceForOneProduct();
    }
    return total;
  }
}
