import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/cubits/userdata/userdata_cubit.dart';
import 'package:salla_commerce_app/Features/Search/presentation/views/search_view.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';
import 'package:salla_commerce_app/core/utils/assets.dart';

class CustomListtile extends StatefulWidget {
  const CustomListtile({super.key});

  @override
  State<CustomListtile> createState() => _CustomListtileState();
}

class _CustomListtileState extends State<CustomListtile> {
  String? name;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserdataCubit, UserdataState>(
      listener: (context, state) {
        if (state is UserdataSuccess) {
          name = state.userData[0].name;
        }
      },
      builder:
          (context, state) => ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage(Assets.imagesPofileImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: Text('Hi!', style: AppStyles.style22),
            subtitle: Text(name ?? '', style: AppStyles.style15),
            trailing: GestureDetector(
              onTap: () {
                GoRouter.of(context).push(SearchView.routeName);
              },
              child: Image.asset(Assets.imagesSearch, width: 30),
            ),
          ),
    );
  }
}
