import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/views/login_view.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/main_home_view.dart';
import 'package:salla_commerce_app/Features/OnBoarding/presentation/views/onboarding_view.dart';
import 'package:salla_commerce_app/core/services/auth_service.dart';
import 'package:salla_commerce_app/core/services/shared_prefrences_service.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      bool isOnboardingSeen = await SharedPrefrenceService.getBool(
        'isOnboardingSeen',
      );
      bool isSignedIn = await AuthService().isSignedIn();
      if (isSignedIn) {
        GoRouter.of(context).pushReplacement(MainHomeView.routeName);
      } else {
        if (isOnboardingSeen) {
          GoRouter.of(context).pushReplacement(LoginView.routeName);
        } else {
          GoRouter.of(context).pushReplacement(OnboardingView.routeName);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffF3F3F3),
                image: const DecorationImage(
                  image: AssetImage(Assets.imagesChatGPTLogo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
