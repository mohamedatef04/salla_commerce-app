import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/widgets/order_item.dart';
import 'package:salla_commerce_app/Features/Profile/view%20model/cubits/my_orders/my_orders_cubit.dart';
import 'package:salla_commerce_app/core/utils/app_colors.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

class MyOrdersViewBody extends StatelessWidget {
  const MyOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders', style: AppStyles.style22),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
        ),
      ),
      body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
        builder: (context, state) {
          if (state is MyOrdersLoaded) {
            return ListView.builder(
              itemCount: state.myOrders.length,
              itemBuilder: (context, index) {
                return OrderItem(productModel: state.myOrders[index]);
              },
            );
          } else if (state is MyOrdersEmpty) {
            return Center(
              child: Text('No Orders Yet', style: AppStyles.style22),
            );
          } else if (state is MyOrdersFailure) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
