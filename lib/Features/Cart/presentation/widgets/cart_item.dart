import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/cart%20cubit/cart_cubit.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.screenWidth,
    required this.productModel,
  });

  final double screenWidth;
  final ProductModel productModel;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        width: widget.screenWidth,
        height: MediaQuery.sizeOf(context).height * 0.18,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            spacing: 5,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: widget.productModel.image ?? '',
                  imageBuilder:
                      (context, imageProvider) => Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder:
                      (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productModel.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.style22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Size: ', style: AppStyles.style15),
                            Text('M |', style: AppStyles.style15),
                            Text(' Color : ', style: AppStyles.style15),
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<CartCubit>().removeFromCart(
                              productModel: widget.productModel,
                            );
                          },
                          child: Image.asset(Assets.imagesDelete, width: 24),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.productModel.calculateTotalPriceForOneProduct()} L.E',
                            style: AppStyles.style18,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffF3F3F3),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.productModel.decreaseCount();
                                    });
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  widget.productModel.quantity.toString(),
                                  style: AppStyles.style18,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.productModel.increaseCount();
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
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
    );
  }
}
