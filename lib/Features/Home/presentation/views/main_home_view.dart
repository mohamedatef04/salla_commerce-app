import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Home/data/repos/home_repo_impl.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/main_home_view_body.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/all%20products%20cubit/allproducts_cubit.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/latest%20arrival%20products%20cubit/latestarrivalproducts_cubit.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/navbar%20cubit/navbar_cubit.dart';
import 'package:salla_commerce_app/Features/Home/view%20model/cubits/recommended%20products%20cubit/recommendedproducts_cubit.dart';
import 'package:salla_commerce_app/Features/exeplore/data/repos/exeplore_repo_impl.dart';
import 'package:salla_commerce_app/Features/exeplore/view%20model/cubits/exeplore_cubit.dart';
import 'package:salla_commerce_app/core/services/get_it_service.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  static const String routeName = '/main-Home-View';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavbarCubit()),

        BlocProvider(
          create: (context) => AllproductsCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create:
              (context) => RecommendedproductsCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  LatestarrivalproductsCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => ExeploreCubit(getIt.get<ExeploreRepoImpl>()),
        ),
      ],
      child: const Scaffold(body: MainHomeViewBody()),
    );
  }
}
