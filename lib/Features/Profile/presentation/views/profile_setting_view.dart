import 'package:flutter/material.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/widgets/profile_setting_view_body.dart';

class ProfileSettingView extends StatelessWidget {
  const ProfileSettingView({super.key});
  static const routeName = '/profile-setting-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ProfileSettingViewBody());
  }
}
