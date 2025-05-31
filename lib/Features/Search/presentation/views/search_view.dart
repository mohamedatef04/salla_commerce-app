import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_commerce_app/Features/Search/data/repos/search_repo_impl.dart';
import 'package:salla_commerce_app/Features/Search/presentation/widgets/search_view_body.dart';
import 'package:salla_commerce_app/Features/Search/view%20model/cubits/search_cubit.dart';
import 'package:salla_commerce_app/core/services/get_it_service.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String routeName = '/Search-View';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt.get<SearchRepoImpl>()),
      child: const Scaffold(body: SearchViewBody()),
    );
  }
}
