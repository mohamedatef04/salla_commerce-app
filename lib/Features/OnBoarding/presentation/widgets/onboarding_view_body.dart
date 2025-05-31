import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/views/login_view.dart';
import 'package:salla_commerce_app/Features/OnBoarding/data/models/onboarding_item_model.dart';
import 'package:salla_commerce_app/Features/OnBoarding/presentation/widgets/onboarding_item.dart';
import 'package:salla_commerce_app/core/services/shared_prefrences_service.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  PageController controller = PageController();
  var currentPage = 0;
  @override
  void initState() {
    controller.addListener(() {
      currentPage = controller.page!.round();
    });
    super.initState();
  }

  List<OnboardingItemModel> items = [
    const OnboardingItemModel(
      image: Assets.imagesOnboard1,
      title: 'Shop Online',
      subTitle:
          'Find the best deals on the items you love. At Metor, you may shop today based on styles, colors, and more.',
    ),
    const OnboardingItemModel(
      image: Assets.imagesOnboard1,
      title: 'Easy Shopping',
      subTitle:
          'Find the best deals on the items you love. At Metor, you may shop today based on styles, colors, and more.',
    ),

    const OnboardingItemModel(
      image: Assets.imagesOnboard2,
      title: 'Make smart payments',
      subTitle:
          'Make smart payments with Metor, the simplest, safest and most rewarding trading platform.',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              PageView(
                controller: controller,

                children:
                    items
                        .map(
                          (e) => OnboardingItem(
                            onboardingItemModel: e,
                            skipClick: items.indexOf(e) != 2,
                            buttonClick: items.indexOf(e) == 2,
                            onSkipTap: () {
                              GoRouter.of(
                                context,
                              ).pushReplacement(LoginView.routeName);
                              SharedPrefrenceService.setBool(
                                'isOnboardingSeen',
                                true,
                              );
                            },
                            onButtonTap: () {
                              GoRouter.of(
                                context,
                              ).pushReplacement(LoginView.routeName);
                            },
                          ),
                        )
                        .toList(),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.75,
                left: MediaQuery.sizeOf(context).width * 0.45,

                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.primaryColor,
                    dotHeight: 10,
                    dotWidth: 10,
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
