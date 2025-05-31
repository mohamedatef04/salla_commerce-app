import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/cart%20cubit/cart_cubit.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/purchased_products/purchased_products_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class CheckOutWidget extends StatelessWidget {
  const CheckOutWidget({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,

      child: Container(
        width: screenWidth,
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            spacing: 10,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PaymentView(
                              onPaymentSuccess: () {
                                for (var element
                                    in context
                                        .read<CartCubit>()
                                        .cartProducts!) {
                                  context
                                      .read<PurchasedProductsCubit>()
                                      .addPurchasedProducts(
                                        productModel: element,
                                      );
                                }
                              },
                              onPaymentError: () {
                                // Handle payment failure
                              },
                              price:
                                  context
                                      .watch<CartCubit>()
                                      .calculatetotalPrice(), // Required: Total price (e.g., 100 for 100 EGP)
                            ),
                      ),
                    );
                  },
                  child: Container(
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xff101010),
                    ),
                    child: Center(
                      child: Text(
                        'Check Out',
                        style: AppStyles.style22.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Total Price : ${context.watch<CartCubit>().calculatetotalPrice()} L.E',
                  textAlign: TextAlign.center,
                  style: AppStyles.style18.copyWith(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
