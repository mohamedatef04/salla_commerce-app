import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Cart/presentation/widgets/cart_view_body.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/cart%20cubit/cart_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/widgets/show_snackbar.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const String routeName = 'cart-view';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartProductsRemoved) {
          showsnackbar(
            context,
            message: 'Removed From Cart',
            color: AppColors.blackColor,
          );
        } else if (state is CartProductsFailure) {
          showsnackbar(context, message: state.errMessage, color: Colors.red);
        } else {
          Center(child: Text('No products in cart', style: AppStyles.style15));
        }
      },
      builder: (context, state) {
        return const Scaffold(body: CartViewBody());
      },
    );
  }
}
