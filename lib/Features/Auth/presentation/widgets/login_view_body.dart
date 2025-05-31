import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/views/forget_password_view.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/views/signup_view.dart';
import 'package:salla_commerce_app/Features/Auth/view%20model/cubits/signin/signin_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';
import 'package:salla_commerce_app/core/widgets/custom_textfield.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                Image.asset(Assets.imagesGroup2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    spacing: 10,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        'Welcome Back !',
                        style: AppStyles.style22.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Login into your account',
                        style: AppStyles.style22.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      CustomTextfield(
                        controller: emailController,
                        hintText: 'Email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          } else if (!value.contains('@')) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.email),
                      ),
                      CustomTextfield(
                        controller: passwordController,
                        obscureText: obsecureText,

                        hintText: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecureText = !obsecureText;
                            });
                          },
                          icon:
                              obsecureText
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push(ForgetPasswordView.routeName);
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: AppStyles.style15,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context
                                .read<SigninCubit>()
                                .signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: AppStyles.style22.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ?',
                            style: AppStyles.style15,
                          ),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(SignupView.routeName);
                            },
                            child: Text(
                              'Sign Up',
                              style: AppStyles.style15.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
