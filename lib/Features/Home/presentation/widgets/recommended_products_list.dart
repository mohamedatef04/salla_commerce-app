import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/product_item.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/recommended%20products%20cubit/recommendedproducts_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class RecommendedProductsList extends StatelessWidget {
  const RecommendedProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedproductsCubit, RecommendedproductsState>(
      builder: (context, state) {
        if (state is RecommendedproductsLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: state.recommendedproducts.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  productModel: state.recommendedproducts[index],
                );
              },
            ),
          );
        } else if (state is RecommendedproductsFailure) {
          return Text('Oops something went wrong', style: AppStyles.style15);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
