import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/product_item.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/latest%20arrival%20products%20cubit/latestarrivalproducts_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class LatestArrivalProductsList extends StatelessWidget {
  const LatestArrivalProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestarrivalproductsCubit, LatestarrivalproductsState>(
      builder: (context, state) {
        if (state is LatestarrivalproductsLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: state.latestarrivalproducts.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  productModel: state.latestarrivalproducts[index],
                );
              },
            ),
          );
        } else if (state is LatestarrivalproductsFailure) {
          return Text(state.errMessage, style: AppStyles.style15);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
