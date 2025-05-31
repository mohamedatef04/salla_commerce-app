import 'package:flutter/material.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String routeName = '/profile-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ProfileViewBody());
  }
}
