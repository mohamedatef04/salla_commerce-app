import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/cart%20cubit/cart_cubit.dart';
import 'package:salla_commerce_app/Features/Favourites/view%20model/cubits/favourite_cubit.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/product_details_view.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
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
    return Card(
      elevation: 7,

      color: Colors.white,
      shadowColor: Colors.grey,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.sizeOf(context).width / 2.5,
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
                  ProductDetailsView.routeName,
                  extra: widget.productModel,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
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
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                    ),
                    Text(
                      widget.productModel.name ?? '',

                      overflow: TextOverflow.ellipsis,

                      style: AppStyles.style15,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Price', style: AppStyles.style15),
                        const Spacer(),
                        Text(
                          '${widget.productModel.price} L.E',
                          style: AppStyles.style15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.sizeOf(context).width * 0.3,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFavourite = true;
                  });
                  context.read<FavouriteCubit>().addToFavourite(
                    productModel: widget.productModel,
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child:
                          isFavourite!
                              ? Image.asset(Assets.imagesRedHeart, height: 40)
                              : Image.asset(Assets.imagesHeart, height: 20),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.sizeOf(context).width * 0.3,
              top: MediaQuery.sizeOf(context).height * 0.1,
              child: GestureDetector(
                onTap: () {
                  context.read<CartCubit>().addToCart(
                    productModel: widget.productModel,
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Image.asset(Assets.imagesCart, height: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
