import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Favourites/presentation/widgets/favourite_item.dart';
import 'package:salla_commerce_app/Features/Favourites/view%20model/cubits/favourite_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';

class FavouriteViewBody extends StatefulWidget {
  const FavouriteViewBody({super.key});

  @override
  State<FavouriteViewBody> createState() => _FavouriteViewBodyState();
}

class _FavouriteViewBodyState extends State<FavouriteViewBody> {
  @override
  void initState() {
    context.read<FavouriteCubit>().getFavouriteProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites', style: AppStyles.style22),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            if (state is EmptyFavouriteProducts) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesEmptyFavourites, width: 200),
                    Text('No Favourite Products', style: AppStyles.style22),
                  ],
                ),
              );
            } else if (state is FavouriteLoaded) {
              return ListView.builder(
                itemCount:
                    context.read<FavouriteCubit>().favouriteProducts.length,
                itemBuilder: (context, index) {
                  return FavouriteItem(
                    productModel:
                        context.read<FavouriteCubit>().favouriteProducts[index],
                  );
                },
              );
            } else if (state is FavouriteUpdatedAfterRemove) {
              return ListView.builder(
                itemCount: state.favouriteProductsAfterRemove.length,
                itemBuilder: (context, index) {
                  return FavouriteItem(
                    productModel: state.favouriteProductsAfterRemove[index],
                  );
                },
              );
            } else if (state is FavouriteFailure) {
              return Center(child: Text(state.errMessage));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
