import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/views/login_view.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/views/my_orders_view.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/views/profile_setting_view.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/cubits/my_orders/my_orders_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  File? pickedImage;
  String? imageName;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppStyles.style22),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          spacing: 15,
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
                Text('Profile Settings', style: AppStyles.style18),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).push(ProfileSettingView.routeName);
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),

            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag),
                ),
                Text('My Orders', style: AppStyles.style18),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).push(MyOrdersView.routeName);
                    context.read<MyOrdersCubit>().getMyOrders();
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    context.go(LoginView.routeName);
                  },
                  icon: const Icon(Icons.logout_outlined),
                ),
                Text('Logout', style: AppStyles.style18),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
