import 'package:nepal_excaliber/models/product.dart';

List<OrderItems> orderItemsFromJson(List<dynamic> orderItemsJson) =>
    List<OrderItems>.from(orderItemsJson
        .map((orderItemJson) => OrderItems.fromJson(orderItemJson)));

class OrderItems {
  int? id;
  String? size;
  String? color;
  int? quantity;
  num? price;
  String? createdAt;
  String? updatedAt;
  int? orderId;
  int? productId;
  Product? product;
  Order? order;

  OrderItems(
      {this.id,
      this.size,
      this.color,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.orderId,
      this.productId,
      this.product,
      this.order});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    color = json['color'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderId = json['orderId'];
    productId = json['productId'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['size'] = size;
    data['color'] = color;
    data['quantity'] = quantity;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['orderId'] = orderId;
    data['productId'] = productId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  double? totalCost;
  String? deliveryStatus;
  String? orderDate;
  String? orderCompleteDate;
  String? paymentToken;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? addressId;

  Order(
      {this.id,
      this.totalCost,
      this.deliveryStatus,
      this.orderDate,
      this.orderCompleteDate,
      this.paymentToken,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.addressId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalCost = json['totalCost'];
    deliveryStatus = json['deliveryStatus'];
    orderDate = json['orderDate'];
    orderCompleteDate = json['orderCompleteDate'];
    paymentToken = json['paymentToken'];
    paymentStatus = json['paymentStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    addressId = json['addressId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalCost'] = totalCost;
    data['deliveryStatus'] = deliveryStatus;
    data['orderDate'] = orderDate;
    data['orderCompleteDate'] = orderCompleteDate;
    data['paymentToken'] = paymentToken;
    data['paymentStatus'] = paymentStatus;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    data['addressId'] = addressId;
    return data;
  }
}
