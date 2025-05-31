import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/exeplore/view%20model/repos/exeplore_repo.dart';

part 'exeplore_state.dart';

class ExeploreCubit extends Cubit<ExeploreState> {
  ExeploreCubit(this.exeploreRepo) : super(ExeploreInitial());

  final ExeploreRepo exeploreRepo;

  Future<void> getAllProducts() async {
    emit(ExeploreProductsLoading());
    final res = await exeploreRepo.getAllProducts();
    res.fold(
      (l) {
        emit(ExeploreProductsFailure(errMessage: l.message));
      },
      (r) {
        emit(ExeploreProductsLoaded(allProducts: r));
      },
    );
  }
}
