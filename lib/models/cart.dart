import 'package:get/get_rx/src/rx_types/rx_types.dart';

List<Cart> cartsFromJson(List<dynamic> cartsJson) =>
    List<Cart>.from(cartsJson.map((cartJson) => Cart.fromJson(cartJson)));

List<dynamic> cartsToJson(List<Cart> carts) =>
    List<dynamic>.from(carts.map((e) => e.toJsonForApi()));

class Cart {
  int? id;
  int? productId;
  String? productTitle;
  num? productPrice;
  RxInt? quantity = RxInt(0);
  String? imageUrl;
  String? category;
  String? sizes;
  String? color;
  bool? hasOffer;
  int? discount;

  Cart(
      {this.id,
      this.productId,
      this.productTitle,
      this.productPrice,
      this.imageUrl,
      this.category,
      this.sizes,
      this.color,
      this.hasOffer,
      this.discount,
      this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    productPrice = json['product_price'];
    quantity!.value = json['quantity'];
    imageUrl = json['image_url'];
    category = json['category'];
    sizes = json['size'];
    color = json['color'];
    hasOffer = json['has_Offer'] == 1;
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['product_price'] = productPrice;
    data['quantity'] = quantity!.value;
    data['image_url'] = imageUrl;
    data['category'] = category;
    data['size'] = sizes;
    data['color'] = color;
    data['has_Offer'] = hasOffer;
    data['discount'] = discount;
    return data;
  }

  Map<String, dynamic> toJsonForApi() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity!.value;
    data['size'] = sizes;
    data['color'] = color;
    data['price'] = productPrice;
    return data;
  }
}
