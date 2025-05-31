import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomOffersWidget extends StatelessWidget {
  const CustomOffersWidget({
    super.key,
    required this.pageController,
    required this.offers,
  });

  final PageController pageController;
  final List<String> offers;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: pageController,
            pageSnapping: true,

            itemCount: offers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CachedNetworkImage(
                  imageUrl: offers[index],
                  imageBuilder:
                      (context, imageProvider) => Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder:
                      (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
          ),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: 3,
          effect: const ExpandingDotsEffect(
            dotColor: Colors.grey,
            activeDotColor: AppColors.primaryColor,
            dotHeight: 10,
            dotWidth: 10,
          ),
        ),
      ],
    );
  }
}
