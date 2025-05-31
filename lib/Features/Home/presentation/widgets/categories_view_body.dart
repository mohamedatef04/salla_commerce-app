import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Home/data/models/category_item_model.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/custom_categories_grid.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/categoy%20products%20cubit/categoryproducts_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/widgets/custom_appbar.dart';

class CategoriesViewBody extends StatefulWidget {
  const CategoriesViewBody({super.key, required this.categoryItemModel});
  final CategoryItemModel categoryItemModel;

  @override
  State<CategoriesViewBody> createState() => _CategoriesViewBodyState();
}

class _CategoriesViewBodyState extends State<CategoriesViewBody> {
  @override
  void initState() {
    context.read<CategoryproductsCubit>().getCategoryProducts(
      category: widget.categoryItemModel.name,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: widget.categoryItemModel.name),

      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text('Sorted By', style: AppStyles.style18),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_drop_down),
                    ),
                  ],
                ),
              ),
              const CaregoriesGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
