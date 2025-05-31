import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:salla_commerce_app/Features/Auth/data/repos/auth_repo_impl.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/widgets/signup_view_body.dart';
import 'package:salla_commerce_app/Features/Auth/view%20model/cubits/signup/signup_cubit.dart';
import 'package:salla_commerce_app/core/services/get_it_service.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/widgets/show_snackbar.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const String routeName = '/signup-view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt.get<AuthRepoImpl>()),
      child: Scaffold(
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              showsnackbar(
                context,
                message: 'Created Successfully',
                color: AppColors.lightPrimaryColor,
              );
              GoRouter.of(context).pop();
            } else if (state is SignupFailure) {
              showsnackbar(
                context,
                message: state.errMessage,
                color: Colors.red,
              );
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is SignupLoading,
              child: const SignupViewBody(),
            );
          },
        ),
      ),
    );
  }
}
