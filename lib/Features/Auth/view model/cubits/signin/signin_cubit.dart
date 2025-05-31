import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Auth/view%20model/repos/auth_repo.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());

  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SigninLoading());
    final res = await authRepo.signInUser(email: email, password: password);

    res.fold(
      (l) {
        emit(SigninFailure(errMessage: l.message));
      },
      (r) {
        emit(SigninSuccess());
      },
    );
  }
}
