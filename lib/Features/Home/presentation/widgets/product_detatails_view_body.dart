import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/cart%20cubit/cart_cubit.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetatailsViewBody extends StatefulWidget {
  const ProductDetatailsViewBody({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductDetatailsViewBody> createState() =>
      _ProductDetatailsViewBodyState();
}

class _ProductDetatailsViewBodyState extends State<ProductDetatailsViewBody> {
  @override
  void initState() {
    if (widget.productModel.favouriteProducts!.isNotEmpty &&
        widget.productModel.favouriteProducts!
            .where((e) => e['for_user'] == userId)
            .isNotEmpty) {
      setState(() {
        isFavourite = true;
      });
    }
    super.initState();
  }

  final String userId = Supabase.instance.client.auth.currentUser!.id;
  bool? isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            spacing: 5,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Card(
                      elevation: 5,
                      color: Colors.white,
                      child: CachedNetworkImage(
                        imageUrl: widget.productModel.image ?? '',
                        imageBuilder:
                            (context, imageProvider) => Container(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                        placeholder:
                            (context, url) => const CircularProgressIndicator(),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: IconButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.productModel.name ?? '',
                                  style: AppStyles.style25,
                                ),
                                const Spacer(),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child:
                                        isFavourite!
                                            ? Image.asset(
                                              Assets.imagesRedHeart,
                                              height: 40,
                                            )
                                            : Image.asset(
                                              Assets.imagesHeart,
                                              height: 30,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.productModel.category ?? '',
                                  style: AppStyles.style18,
                                ),
                                const Spacer(),
                                Text('Rate 4.5 ⭐', style: AppStyles.style18),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Description', style: AppStyles.style25),
                              ],
                            ),
                            Text(
                              widget.productModel.description ?? '',
                              style: AppStyles.style15.copyWith(
                                color: Colors.blueGrey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Price', style: AppStyles.style22),
                                    Text(
                                      '${widget.productModel.price} L.E',
                                      style: AppStyles.style18,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  width: 150,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<CartCubit>().addToCart(
                                        productModel: widget.productModel,
                                      );
                                    },
                                    child: Row(
                                      spacing: 5,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.shopping_bag,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Add to Cart',
                                          style: AppStyles.style18.copyWith(
                                            color: Colors.white,
                                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
