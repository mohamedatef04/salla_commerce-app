import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:salla_commerce_app/Features/Auth/data/repos/auth_repo_impl.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/widgets/login_view_body.dart';
import 'package:salla_commerce_app/Features/Auth/view%20model/cubits/signin/signin_cubit.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/main_home_view.dart';
import 'package:salla_commerce_app/core/services/get_it_service.dart';
import 'package:salla_commerce_app/core/widgets/show_snackbar.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const routeName = '/login-view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(getIt.get<AuthRepoImpl>()),
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccess) {
            GoRouter.of(context).pushReplacement(MainHomeView.routeName);
          } else if (state is SigninFailure) {
            showsnackbar(context, message: state.errMessage, color: Colors.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: state is SigninLoading,

              child: const LoginViewBody(),
            ),
          );
        },
      ),
    );
  }
}
