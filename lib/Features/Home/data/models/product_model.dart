class ProductModel {
  final String? id;
  final String? name;
  final String? image;
  final String? description;
  final String? price;
  final String? category;
  final bool? isRecommended;
  final bool? isLatestArrival;
  final List? cartProducts;
  final List? favouriteProducts;
  final List? orders;
  int quantity = 1;

  ProductModel({
    this.id,
    this.name,
    this.image,
    this.description,
    this.price,
    this.category,
    this.isRecommended,
    this.isLatestArrival,
    this.cartProducts,
    this.favouriteProducts,
    this.orders,
  });

  factory ProductModel.fromJson(json) {
    return ProductModel(
      id: json['product_id'],
      name: json['product_name'],
      image: json['product_image'],
      description: json['product_description'],
      price: json['product_price'],
      category: json['product_category'],
      isRecommended: json['is_recommended'],
      isLatestArrival: json['is_latest_arrival'],
      cartProducts: json['cart_products'],
      favouriteProducts: json['favourite_products'],
      orders: json['purchased_products'],
    );
  }
  increaseCount() {
    quantity++;
  }

  decreaseCount() {
    if (quantity > 1) {
      quantity--;
    }
  }

  calculateTotalPriceForOneProduct() {
    return int.parse(price!) * quantity;
  }
}
