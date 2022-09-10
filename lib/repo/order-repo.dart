import 'dart:convert';

import 'package:nepal_excaliber/models/order.dart';

import '../models/cart.dart';
import '../utils/api.dart';
import '../utils/http-request.dart';
import '../utils/storage-helper.dart';
import 'package:http/http.dart' as http;

class OrderRepo {
  static Future<void> placeOrder(
      {required String totalCost,
      required String addressId,
      required String paymentToken,
      required List<Cart> products,
      required Function() onSuccess,
      required Function(String) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };

      var body = {
        "totalCost": totalCost,
        "paymentStatus": "Complete",
        "addressId": addressId,
        "paymentToken": paymentToken,
        "products": cartsToJson(products)
      };

      print(body);
      http.Response response = await HttpRequest.post(
          Uri.parse(Api.placeOrderUrl),
          headers: headers,
          body: json.encode(body));

      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      onError("Something went wrong !!!!");
    }
  }

  static Future<void> getOrder(
      {required Function(List<OrderItems>) onSuccess,
      required Function(String) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };

      http.Response response =
          await HttpRequest.get(Uri.parse(Api.getOrdersUrl), headers: headers);
      dynamic data = jsonDecode(response.body);
      print(data);
      if (data["status"]) {
        var orders = orderItemsFromJson(data['data']);
        print("Ordet Item ==========>");
        print(orders[0].toJson());
        onSuccess(orders);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      print(e);
      print(s);
      onError("Sorry something went wrong!!!!.");
    }
  }
}
