import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';

abstract class PurchasedProductsRepo {
  Future<void> addToPurchased({required ProductModel productModel});
}
