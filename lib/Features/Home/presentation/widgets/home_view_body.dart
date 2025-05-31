import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Home/data/models/category_item_model.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/custom_categories_item.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/custom_listtile.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/custom_offers_widget.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/latest_arrival_products_list.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/recommended_products_list.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/all%20products%20cubit/allproducts_cubit.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/latest%20arrival%20products%20cubit/latestarrivalproducts_cubit.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/recommended%20products%20cubit/recommendedproducts_cubit.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/cubits/userdata/userdata_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  PageController pageController = PageController();
  List<String> offers = [
    'https://img.freepik.com/free-psd/3d-sales-discount-price-tag-composition-50-percent_314999-2100.jpg?uid=R145483694&ga=GA1.1.918032716.1736258875&w=740',
    'https://img.freepik.com/free-vector/stylish-sale-offers-origami-chat-bubble-banner_1017-17640.jpg?uid=R145483694&ga=GA1.1.918032716.1736258875&semt=ais_hybrid&w=740',
    'https://img.freepik.com/free-vector/realistic-hanging-sales-label-collection_52683-31464.jpg?uid=R145483694&ga=GA1.1.918032716.1736258875&semt=ais_hybrid&w=740',
  ];
  List<CategoryItemModel> categoryItems = [
    CategoryItemModel(image: Assets.imagesClothes, name: 'Clothes'),
    CategoryItemModel(image: Assets.imagesShoesCategory, name: 'Shoes'),
    CategoryItemModel(image: Assets.imagesBagCategory, name: 'Bags'),
    CategoryItemModel(image: Assets.imagesWatchCategory, name: 'Watches'),
  ];
  List<CategoryItemModel> categoryItems2 = [
    CategoryItemModel(
      image: Assets.imagesElectronicsCategory,
      name: 'Electronics',
    ),
    CategoryItemModel(image: Assets.imagesJewelleryCategory, name: 'Jewellery'),
    CategoryItemModel(image: Assets.imagesToysCategory, name: 'Toys'),
    CategoryItemModel(image: Assets.imagesToolsCategory, name: 'Tools'),
  ];
  @override
  void initState() {
    context.read<UserdataCubit>().getUserData();
    context.read<AllproductsCubit>().getAllProducts();

    context.read<RecommendedproductsCubit>().getRecommendedProducts();
    context.read<LatestarrivalproductsCubit>().getLatestArrivalProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    spacing: 10,
                    children: [
                      const CustomListtile(),
                      Row(
                        children: [
                          Text('New Offers', style: AppStyles.style22),
                        ],
                      ),

                      CustomOffersWidget(
                        pageController: pageController,
                        offers: offers,
                      ),

                      Row(
                        children: [
                          Text('Categories', style: AppStyles.style22),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            categoryItems
                                .map(
                                  (e) => CustomCategoriesItem(
                                    categoryItemModel: e,
                                  ),
                                )
                                .toList(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            categoryItems2
                                .map(
                                  (e) => CustomCategoriesItem(
                                    categoryItemModel: e,
                                  ),
                                )
                                .toList(),
                      ),

                      Row(
                        children: [
                          Text('Recommended', style: AppStyles.style22),
                        ],
                      ),
                      const RecommendedProductsList(),
                      Row(
                        children: [
                          Text('Latest Arrivals', style: AppStyles.style22),
                        ],
                      ),
                      const LatestArrivalProductsList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
