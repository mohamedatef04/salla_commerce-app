import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/views/forget_password_view.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/views/login_view.dart';
import 'package:salla_commerce_app/Features/Auth/presentation/views/signup_view.dart';
import 'package:salla_commerce_app/Features/Cart/presentation/views/cart_view.dart';
import 'package:salla_commerce_app/Features/Favourites/presentation/views/favourite_view.dart';
import 'package:salla_commerce_app/Features/Home/data/models/category_item_model.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/categories_view.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/home_view.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/main_home_view.dart';
import 'package:salla_commerce_app/Features/Home/presentation/views/product_details_view.dart';
import 'package:salla_commerce_app/Features/OnBoarding/presentation/views/onboarding_view.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/views/my_orders_view.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/views/profile_setting_view.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/views/profile_view.dart';
import 'package:salla_commerce_app/Features/Search/presentation/views/search_view.dart';
import 'package:salla_commerce_app/Features/Splash/presentation/views/splash_view.dart';
import 'package:salla_commerce_app/Features/exeplore/presentation/views/exeplore_view.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(
      path: OnboardingView.routeName,
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: LoginView.routeName,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: SignupView.routeName,
      builder: (context, state) => const SignupView(),
    ),
    GoRoute(
      path: ForgetPasswordView.routeName,
      builder: (context, state) => const ForgetPasswordView(),
    ),
    GoRoute(
      path: MainHomeView.routeName,
      builder: (context, state) => const MainHomeView(),
    ),
    GoRoute(
      path: HomeView.routeName,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: ExeploreView.routeName,
      builder: (context, state) => const ExeploreView(),
    ),
    GoRoute(
      path: CategoriesView.routeName,
      builder:
          (context, state) => CategoriesView(
            categoryItemModel: state.extra as CategoryItemModel,
          ),
    ),
    GoRoute(
      path: ProductDetailsView.routeName,
      builder:
          (context, state) =>
              ProductDetailsView(productModel: state.extra as ProductModel),
    ),
    GoRoute(
      path: CartView.routeName,
      builder: (context, state) => const CartView(),
    ),
    GoRoute(
      path: FavouriteView.routeName,
      builder: (context, state) => const FavouriteView(),
    ),
    GoRoute(
      path: SearchView.routeName,
      builder: (context, state) => const SearchView(),
    ),
    GoRoute(
      path: ProfileView.routeName,
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: ProfileSettingView.routeName,
      builder: (context, state) => const ProfileSettingView(),
    ),
    GoRoute(
      path: MyOrdersView.routeName,
      builder: (context, state) => const MyOrdersView(),
    ),
  ],
);
