import 'package:flutter/material.dart';
import 'package:salla_commerce_app/Features/OnBoarding/data/models/onboarding_item_model.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.onboardingItemModel,
    required this.onSkipTap,
    required this.skipClick,
    required this.buttonClick,
    required this.onButtonTap,
  });
  final OnboardingItemModel onboardingItemModel;
  final void Function()? onSkipTap;
  final void Function()? onButtonTap;
  final bool skipClick;
  final bool buttonClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        spacing: 20,
        children: [
          Visibility(
            visible: skipClick,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: GestureDetector(
                onTap: onSkipTap,
                child: Text(
                  'Skip',
                  textAlign: TextAlign.end,
                  style: AppStyles.style15,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height / 10),
          Image.asset(
            onboardingItemModel.image,
            height: MediaQuery.sizeOf(context).height / 3,
          ),
          Text(
            onboardingItemModel.title,
            style: AppStyles.style22.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            onboardingItemModel.subTitle,
            textAlign: TextAlign.center,
            style: AppStyles.style18.copyWith(color: Colors.grey),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height / 10),
          Visibility(
            visible: buttonClick,
            child: GestureDetector(
              onTap: onButtonTap,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
