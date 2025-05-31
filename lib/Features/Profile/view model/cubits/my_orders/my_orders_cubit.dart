import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/repos/profile_repo.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit(this.profileRepo) : super(MyOrdersInitial());
  final ProfileRepo profileRepo;

  Future<void> getMyOrders() async {
    emit(MyOrdersLoading());
    final res = await profileRepo.getMyOrders();
    res.fold(
      (l) {
        emit(MyOrdersFailure(errorMessage: l.message));
      },
      (r) {
        if (r.isEmpty) {
          emit(MyOrdersEmpty());
        } else {
          emit(MyOrdersLoaded(myOrders: r));
        }
      },
    );
  }
}
