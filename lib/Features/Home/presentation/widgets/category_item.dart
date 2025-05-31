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

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool? isFavourite = false;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(ProductDetailsView.routeName, extra: widget.productModel);
      },
      child: Card(
        elevation: 7,

        color: Colors.white,
        shadowColor: Colors.grey,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.sizeOf(context).width / 2.5,

          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
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
                    Row(
                      children: [
                        Text('Rate', style: AppStyles.style15),
                        const Spacer(),
                        Text('4.2 ⭐', style: AppStyles.style15),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: MediaQuery.sizeOf(context).width * 0.34,
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
                left: MediaQuery.sizeOf(context).width * 0.34,
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
      ),
    );
  }
}
