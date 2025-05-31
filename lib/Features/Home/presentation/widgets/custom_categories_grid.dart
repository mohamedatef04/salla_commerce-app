import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/category_item.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/categoy%20products%20cubit/categoryproducts_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class CaregoriesGrid extends StatelessWidget {
  const CaregoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryproductsCubit, CategoryproductsState>(
      builder: (context, state) {
        if (state is CategoryproductsLoaded) {
          return SliverGrid.builder(
            itemCount: state.categoryproducts.length,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: MediaQuery.sizeOf(context).height * 0.0009,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return CategoryItem(productModel: state.categoryproducts[index]);
            },
          );
        } else if (state is CategoryproductsFailure) {
          return SliverToBoxAdapter(
            child: Text(state.errMessage, style: AppStyles.style15),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
