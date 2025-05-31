import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Profile/data/models/user_model.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/repos/profile_repo.dart';

part 'userdata_state.dart';

class UserdataCubit extends Cubit<UserdataState> {
  UserdataCubit(this.profileRepo) : super(UserdataInitial());

  final ProfileRepo profileRepo;

  Future<void> getUserData() async {
    emit(UserdataLoading());

    final res = await profileRepo.getUserData();
    res.fold(
      (l) {
        emit(UserdataFailure(message: l.message));
      },
      (r) {
        emit(UserdataSuccess(userData: r));
      },
    );
  }
}
