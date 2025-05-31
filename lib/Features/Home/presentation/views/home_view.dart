import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/cart%20cubit/cart_cubit.dart';
import 'package:salla_commerce_app/Features/Favourites/view%20model/cubits/favourite_cubit.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/widgets/show_snackbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = '/home-view';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartProductsAdded) {
          showsnackbar(
            context,
            message: 'Added to Cart 🛒',
            color: AppColors.blackColor,
          );
        } else if (state is CartProductAlreadyInCart) {
          showsnackbar(
            context,
            message: 'Product Already in Cart',
            color: Colors.red,
          );
        } else if (state is CartProductsFailure) {
          showsnackbar(
            context,
            message: state.errMessage,
            color: AppColors.blackColor,
          );
        }
      },
      builder: (context, state) {
        return BlocConsumer<FavouriteCubit, FavouriteState>(
          listener: (context, state) {
            if (state is FavouriteAdded) {
              showsnackbar(
                context,
                message: 'Added to Favourite ❤️',
                color: AppColors.blackColor,
              );
            } else if (state is FavouriteProductAlreadyInFavourites) {
              showsnackbar(
                context,
                message: 'Product Already in Favourites',
                color: Colors.red,
              );
            } else if (state is FavouriteFailure) {
              showsnackbar(
                context,
                message: state.errMessage,
                color: AppColors.blackColor,
              );
            }
          },
          builder: (context, state) {
            return const Scaffold(body: HomeViewBody());
          },
        );
      },
    );
  }
}
