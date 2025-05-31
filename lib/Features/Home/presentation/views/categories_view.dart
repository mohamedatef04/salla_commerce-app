import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Home/data/models/category_item_model.dart';
import 'package:salla_commerce_app/Features/Home/data/repos/home_repo_impl.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/categories_view_body.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/categoy%20products%20cubit/categoryproducts_cubit.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key, required this.categoryItemModel});
  static const String routeName = '/Categories-View';
  final CategoryItemModel categoryItemModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryproductsCubit(HomeRepoImpl(ApiService())),
      child: Scaffold(
        body: CategoriesViewBody(categoryItemModel: categoryItemModel),
      ),
    );
  }
}
