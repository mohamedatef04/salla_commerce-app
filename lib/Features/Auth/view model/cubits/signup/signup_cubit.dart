import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Auth/view%20model/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    final res = await authRepo.signUpNewUser(
      name: name,
      email: email,
      password: password,
    );

    res.fold(
      (l) {
        emit(SignupFailure(errMessage: l.message));
      },
      (r) {
        emit(SignupSuccess());
      },
    );
  }
}
