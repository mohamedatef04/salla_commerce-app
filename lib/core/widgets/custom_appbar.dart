import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppbar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
      ),
      title: Text(title ?? '', style: AppStyles.style22),
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
