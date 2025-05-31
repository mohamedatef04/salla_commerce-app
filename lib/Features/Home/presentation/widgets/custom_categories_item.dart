import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Home/data/models/category_item_model.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/categories_view.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class CustomCategoriesItem extends StatelessWidget {
  const CustomCategoriesItem({super.key, required this.categoryItemModel});
  final CategoryItemModel categoryItemModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(CategoriesView.routeName, extra: categoryItemModel);
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(categoryItemModel.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(categoryItemModel.name, style: AppStyles.style15),
        ],
      ),
    );
  }
}
