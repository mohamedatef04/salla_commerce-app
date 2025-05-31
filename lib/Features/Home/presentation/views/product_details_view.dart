import 'package:flutter/material.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Home/presentation/widgets/product_detatails_view_body.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productModel});
  static const String routeName = '/Product-Details';
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProductDetatailsViewBody(productModel: productModel));
  }
}
