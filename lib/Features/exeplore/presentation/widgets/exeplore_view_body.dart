import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/exeplore/presentation/widgets/exeplore_product_item.dart';
import 'package:salla_commerce_app/Features/exeplore/view%20model/cubits/exeplore_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class ExeploreViewBody extends StatefulWidget {
  const ExeploreViewBody({super.key});

  @override
  State<ExeploreViewBody> createState() => _ExeploreViewBodyState();
}

class _ExeploreViewBodyState extends State<ExeploreViewBody> {
  @override
  void initState() {
    context.read<ExeploreCubit>().getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exeplore', style: AppStyles.style22),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
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
              BlocBuilder<ExeploreCubit, ExeploreState>(
                builder: (context, state) {
                  if (state is ExeploreProductsLoaded) {
                    return SliverGrid.builder(
                      itemCount: state.allProducts.length,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio:
                            MediaQuery.sizeOf(context).height * 0.0009,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return ExeploreProductItem(
                          productModel: state.allProducts[index],
                        );
                      },
                    );
                  } else if (state is ExeploreProductsFailure) {
                    return SliverToBoxAdapter(
                      child: Text(state.errMessage, style: AppStyles.style15),
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
