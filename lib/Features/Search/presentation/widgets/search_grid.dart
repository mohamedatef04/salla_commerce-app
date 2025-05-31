import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Search/presentation/widgets/search_item.dart';
import 'package:salla_commerce_app/Features/Search/view%20model/cubits/search_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';

class SearchGrid extends StatelessWidget {
  const SearchGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          return SliverGrid.builder(
            itemCount: context.read<SearchCubit>().productAfterSearch.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return SearchItem(
                productModel:
                    context.read<SearchCubit>().productAfterSearch[index],
              );
            },
          );
        } else if (state is SearchFailure) {
          return SliverToBoxAdapter(
            child: Text(state.errMessage, style: AppStyles.style15),
          );
        } else {
          return SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15,
                  children: [
                    Text(
                      'Start Searching Now',
                      textAlign: TextAlign.center,
                      style: AppStyles.style22,
                    ),
                    Image.asset(Assets.imagesSearch1, width: 50),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
