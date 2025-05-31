import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Cart/presentation/widgets/cart_item.dart';
import 'package:salla_commerce_app/Features/Cart/presentation/widgets/check_out_widget.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/cart%20cubit/cart_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    context.read<CartCubit>().getCartProducts();

    super.initState();
  }

  bool? isEmpty = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart', style: AppStyles.style22),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        width: screenWidth,
        child: Stack(
          children: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartProductsIsEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.imagesEmptyCart, width: 200),
                        Text('Your Cart is Empty', style: AppStyles.style22),
                      ],
                    ),
                  );
                } else if (state is CartProductsLoaded) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: context.read<CartCubit>().cartProducts!.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        screenWidth: screenWidth,
                        productModel:
                            context.read<CartCubit>().cartProducts![index],
                      );
                    },
                  );
                } else if (state is CartProductsUpdatedAfterRemove) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: context.read<CartCubit>().cartProducts!.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        screenWidth: screenWidth,
                        productModel:
                            context.read<CartCubit>().cartProducts![index],
                      );
                    },
                  );
                } else if (state is CartProductsFailure) {
                  return Center(
                    child: Text(state.errMessage, style: AppStyles.style15),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            CheckOutWidget(screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}
