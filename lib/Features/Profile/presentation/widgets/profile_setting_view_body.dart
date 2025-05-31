import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/cubits/userdata/userdata_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class ProfileSettingViewBody extends StatefulWidget {
  const ProfileSettingViewBody({super.key});

  @override
  State<ProfileSettingViewBody> createState() => _ProfileSettingViewBodyState();
}

class _ProfileSettingViewBodyState extends State<ProfileSettingViewBody> {
  @override
  void initState() {
    context.read<UserdataCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile details', style: AppStyles.style22),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
        ),
      ),
      body: BlocBuilder<UserdataCubit, UserdataState>(
        builder: (context, state) {
          if (state is UserdataSuccess) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.black),

                    title: Text('User Name', style: AppStyles.style15),
                    subtitle: Text(
                      state.userData[0].name,
                      style: AppStyles.style18,
                    ),
                    trailing: const Icon(Icons.edit, color: Colors.black),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.black),

                    title: Text('Email', style: AppStyles.style15),
                    subtitle: Text(
                      state.userData[0].email,
                      style: AppStyles.style18,
                    ),
                    trailing: const Icon(Icons.edit, color: Colors.black),
                  ),
                ],
              ),
            );
          } else if (state is UserdataFailure) {
            return const Center(child: Text('Error'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
