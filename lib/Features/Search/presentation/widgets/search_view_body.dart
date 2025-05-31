import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Search/presentation/widgets/search_grid.dart';
import 'package:salla_commerce_app/Features/Search/view%20model/cubits/search_cubit.dart';
import 'package:salla_commerce_app/core/widgets/custom_appbar.dart';
import 'package:salla_commerce_app/core/widgets/custom_textfield.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Search'),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CustomTextfield(
                  hintText: 'Search a product',
                  controller: searchController,
                  onChanged: (value) {
                    context.read<SearchCubit>().searchProducts(query: value);
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 15)),
              const SearchGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
