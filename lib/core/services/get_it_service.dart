import 'package:get_it/get_it.dart';
import 'package:salla_commerce_app/Features/Auth/data/repos/auth_repo_impl.dart';
import 'package:salla_commerce_app/Features/Cart/data/repos/cart_repo_impl.dart';
import 'package:salla_commerce_app/Features/Cart/data/repos/purchased_products_repo_impl.dart';
import 'package:salla_commerce_app/Features/Favourites/data/repos/favourite_repo_impl.dart';
import 'package:salla_commerce_app/Features/Home/data/repos/home_repo_impl.dart';
import 'package:salla_commerce_app/Features/Profile/data/repos/profile_repo_impl.dart';
import 'package:salla_commerce_app/Features/Search/data/repos/search_repo_impl.dart';
import 'package:salla_commerce_app/Features/exeplore/data/repos/exeplore_repo_impl.dart';
import 'package:salla_commerce_app/core/services/api_service.dart';
import 'package:salla_commerce_app/core/services/auth_service.dart';
import 'package:salla_commerce_app/core/services/supabase_databse_service.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<SupabaseDatabseService>(SupabaseDatabseService());

  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(getIt.get<AuthService>(), getIt.get<SupabaseDatabseService>()),
  );
  getIt.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(getIt.get<ApiService>()),
  );

  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ExeploreRepoImpl>(
    ExeploreRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<CartRepoImpl>(CartRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<FavouriteRepoImpl>(
    FavouriteRepoImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<PurchasedProductsRepoImpl>(
    PurchasedProductsRepoImpl(apiService: getIt.get<ApiService>()),
  );

  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(
      getIt.get<SupabaseDatabseService>(),
      getIt.get<ApiService>(),
    ),
  );
}
