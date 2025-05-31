import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Favourites/presentation/widgets/favourite_view_body.dart';
import 'package:salla_commerce_app/Features/Favourites/view%20model/cubits/favourite_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/widgets/show_snackbar.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});
  static const String routeName = '/Favourite-View';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteRemoved) {
          showsnackbar(
            context,
            message: 'Removed From Favourite',
            color: AppColors.blackColor,
          );
        } else if (state is FavouriteFailure) {
          showsnackbar(context, message: state.errMessage, color: Colors.red);
        }
      },
      builder: (context, state) {
        return const Scaffold(body: FavouriteViewBody());
      },
    );
  }
}
