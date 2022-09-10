import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nepal_excaliber/models/product.dart';
import 'package:nepal_excaliber/utils/storage-helper.dart';
import '../utils/api.dart';
import '../utils/http-request.dart';

class ProductRepo {
  Future<void> getLatestProduct(
      {required int page,
      required int limit,
      required Function(List<Product>, bool) onSuccess,
      required Function(String) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };

      http.Response response = await HttpRequest.get(
          Uri.parse("${Api.latestProductsUrl}/?limit=$limit&page=$page"),
          headers: headers);
      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        onSuccess(productsFromJson(data['data']['products']),
            data['data']['hasNextPage']);
      } else {
        onSuccess([], data['data']['hasNextPage']);
      }
    } catch (e) {
      onError("Sorry! Something went wrong");
    }
  }

  Future<void> getFeaturedProduct(
      {required int page,
      required Function(List<Product>, bool) onSuccess,
      required Function(String) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };

      http.Response response = await HttpRequest.get(
          Uri.parse("${Api.featuredProductsUrl}/?page=$page"),
          headers: headers);
      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        onSuccess(productsFromJson(data['data']['products']),
            data['data']['hasNextPage']);
      } else {
        onSuccess([], data['data']['hasNextPage']);
      }
    } catch (e) {
      onError("Sorry! Something went wrong");
    }
  }

  Future<Map<String, dynamic>> getCategoryProducts(
      int categoryId, int page) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };

      http.Response response = await HttpRequest.get(
          Uri.parse(
              "${Api.categoryProductsUrl}?categoryId=$categoryId&page=$page"),
          headers: headers);
      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        return {
          "hasNextPage": data['data']['hasNextPage'],
          "products": productsFromJson(data['data']['products'])
        };
      } else {
        return {"hasNextPage": false, "products": []};
      }
    } catch (e) {
      return {"hasNextPage": false, "products": []};
    }
  }

  Future<bool> checkInWishList(int productId) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };

      http.Response response = await HttpRequest.post(
          Uri.parse("${Api.inWishListUrl}?productId=$productId"),
          headers: headers);
      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        return data['inWishlist'];
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> toogleToWishList(int productId, bool inWishList) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };
      final url = "${Api.toogleWishlistUrl}?productId=$productId";
      http.Response response =
          await HttpRequest.post(Uri.parse(url), headers: headers);
      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        return !inWishList;
      } else {
        return inWishList;
      }
    } catch (e) {
      return inWishList;
    }
  }

  Future<List<Product>> getWishList() async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };
      http.Response response =
          await HttpRequest.post(Uri.parse(Api.wishlistUrl), headers: headers);
      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        return productsFromJson(data['products']);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Product>> searchProducts(
      {required String categoryId, required String query}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };
      var url = "${Api.searchProductsUrl}/?id=$categoryId&q=$query";
      print(url);
      http.Response response =
          await HttpRequest.get(Uri.parse(url), headers: headers);
      dynamic data = jsonDecode(response.body);
      print(data);
      if (data["status"]) {
        return productsFromJson(data['data']['rows']);
      } else {
        return [];
      }
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }
}
