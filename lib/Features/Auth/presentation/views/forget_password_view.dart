import 'package:flutter/material.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/widgets/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  static const String routeName = '/forget-password-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ForgetPasswordViewBody());
  }
}
