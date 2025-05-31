import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:salla_commerce_app/Features/Cart/presentation/views/cart_view.dart';
import 'package:salla_commerce_app/Features/Favourites/presentation/views/favourite_view.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/home_view.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/navbar%20cubit/navbar_cubit.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/views/profile_view.dart';
import 'package:salla_commerce_app/Features/exeplore/presentation/views/exeplore_view.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';

class MainHomeViewBody extends StatefulWidget {
  const MainHomeViewBody({super.key});

  @override
  State<MainHomeViewBody> createState() => _MainHomeViewBodyState();
}

class _MainHomeViewBodyState extends State<MainHomeViewBody> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeView(),
    const ExeploreView(),
    const CartView(),
    const FavouriteView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavbarCubit, NavbarState>(
      listener: (context, state) {
        if (state is NavbarChanged) {
          selectedIndex = context.read<NavbarCubit>().selectedIndex;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: screens[selectedIndex],
          bottomNavigationBar: GNav(
            tabMargin: const EdgeInsets.all(15),

            // tab button ripple color when pressed
            haptic: true, // haptic feedback
            tabBorderRadius: 15,

            curve: Curves.easeIn, // tab animation curves
            duration: const Duration(
              milliseconds: 200,
            ), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: AppColors.primaryColor, // selected icon and text color
            iconSize: 20, // tab button icon size
            tabBackgroundColor: const Color.fromARGB(48, 147, 196, 255),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            onTabChange: (value) {
              context.read<NavbarCubit>().changeIndex(value);
            }, // navigation bar padding
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.explore, text: 'Explore'),
              GButton(icon: Icons.shopping_cart, text: 'Cart'),
              GButton(icon: Icons.favorite, text: 'Favourites'),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}
