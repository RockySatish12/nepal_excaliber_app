import 'dart:convert';

import 'category.dart';

List<Product> productsFromJson(List<dynamic> productsJson) =>
    List<Product>.from(
        productsJson.map((productJson) => Product.fromJson(productJson)));

class Product {
  List<dynamic>? sizes;
  List<dynamic>? colors;
  int? id;
  String? title;
  num? price;
  String? description;
  int? quantity;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  bool? hasOffer;
  bool? isFeatured;
  int? discount;
  Category? category;

  Product(
      {this.sizes,
      this.colors,
      this.id,
      this.title,
      this.price,
      this.description,
      this.quantity,
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.category});

  Product.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['sizes'] != null) {
      try {
        sizes = jsonData['sizes'];
      } catch (e) {
        sizes = json.decode(jsonData['sizes']);
      }
    }
    if (jsonData['colors'] != null) {
      try {
        colors = jsonData['colors'];
      } catch (e) {
        colors = json.decode(jsonData['colors']);
      }
    }
    id = jsonData['id'];
    title = jsonData['title'];
    price = jsonData['price'];
    description = jsonData['description'];
    quantity = jsonData['quantity'];
    imageUrl = jsonData['imageUrl'];
    createdAt = jsonData['createdAt'];
    updatedAt = jsonData['updatedAt'];
    categoryId = jsonData['categoryId'];
    hasOffer = jsonData['hasOffer'];
    isFeatured = jsonData['isFeatures'];
    discount = jsonData['discount'];
    category = jsonData['category'] != null
        ? Category.fromJson(jsonData['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizes'] = sizes;
    data['colors'] = colors;
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['quantity'] = quantity;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['categoryId'] = categoryId;
    data['discount'] = discount;
    data['hasOffer'] = hasOffer;
    data['isFeatures'] = isFeatured;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}
