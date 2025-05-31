import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Favourites/view%20model/cubits/favourite_cubit.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/product_details_view.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(ProductDetailsView.routeName, extra: productModel);
      },
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          width: screenWidth,
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
                    imageUrl: productModel.image ?? '',
                    imageBuilder:
                        (context, imageProvider) => Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
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
                Expanded(
                  flex: 2,
                  child: Column(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.name ?? '',
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
                              context
                                  .read<FavouriteCubit>()
                                  .removeFromFavourites(
                                    productModel: productModel,
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
                              '${productModel.price} L.E',
                              style: AppStyles.style18,
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
      ),
    );
  }
}
