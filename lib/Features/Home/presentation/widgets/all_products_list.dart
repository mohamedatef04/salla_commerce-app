import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/product_item.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/all%20products%20cubit/allproducts_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class AllProductsList extends StatelessWidget {
  const AllProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllproductsCubit, AllproductsState>(
      builder: (context, state) {
        if (state is AllproductsLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: state.allproducts.length,
              itemBuilder: (context, index) {
                return ProductItem(productModel: state.allproducts[index]);
              },
            ),
          );
        } else if (state is AllproductsFailure) {
          return Text('Oops something went wrong', style: AppStyles.style15);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
