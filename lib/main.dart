import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:salla_commerce_app/Features/Cart/data/repos/cart_repo_impl.dart';
import 'package:salla_commerce_app/Features/Cart/data/repos/purchased_products_repo_impl.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/cart%20cubit/cart_cubit.dart';
import 'package:salla_commerce_app/Features/Cart/view%20model/cubits/purchased_products/purchased_products_cubit.dart';
import 'package:salla_commerce_app/Features/Favourites/data/repos/favourite_repo_impl.dart';
import 'package:salla_commerce_app/Features/Favourites/view%20model/cubits/favourite_cubit.dart';
import 'package:salla_commerce_app/Features/Profile/data/repos/profile_repo_impl.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/cubits/my_orders/my_orders_cubit.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/cubits/userdata/userdata_cubit.dart';
import 'package:salla_commerce_app/core/services/get_it_service.dart';
import 'package:salla_commerce_app/core/services/shared_prefrences_service.dart';
import 'package:salla_commerce_app/core/utils/app_routes.dart';
import 'package:salla_commerce_app/core/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefrenceService.init();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  getItSetup();
  PaymentData.initialize(
    apiKey:
        paymopApiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
    iframeId: iframeId, // Required: Found under Developers -> iframes
    integrationCardId:
        integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
    integrationMobileWalletId:
        integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
    // Optional Style Customizations
    style: Style(
      primaryColor: Colors.blue, // Default: Colors.blue
      scaffoldColor: Colors.white, // Default: Colors.white
      appBarBackgroundColor: Colors.blue, // Default: Colors.blue
      appBarForegroundColor: Colors.white, // Default: Colors.white
      textStyle: const TextStyle(), // Default: TextStyle()
      buttonStyle:
          ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
      circleProgressColor: Colors.blue, // Default: Colors.blue
      unselectedColor: Colors.grey, // Default: Colors.grey
    ),
  );

  runApp(const SallaCommerceApp());
}

class SallaCommerceApp extends StatelessWidget {
  const SallaCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit(getIt.get<CartRepoImpl>())),
        BlocProvider(
          create: (context) => FavouriteCubit(getIt.get<FavouriteRepoImpl>()),
        ),
        BlocProvider(
          create:
              (context) => PurchasedProductsCubit(
                getIt.get<PurchasedProductsRepoImpl>(),
              ),
        ),
        BlocProvider(
          create: (context) => UserdataCubit(getIt.get<ProfileRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => MyOrdersCubit(getIt.get<ProfileRepoImpl>()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
