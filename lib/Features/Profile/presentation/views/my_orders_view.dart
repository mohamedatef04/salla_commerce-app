import 'package:flutter/material.dart';
import 'package:salla_commerce_app/Features/Profile/presentation/widgets/my_orders_view_body.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});
  static const String routeName = '/my-Orders-View';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MyOrdersViewBody());
  }
}
