import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nepal_excaliber/models/address.dart';
import '../utils/api.dart';
import '../utils/http-request.dart';
import '../utils/storage-helper.dart';

class AddressRepo {
  static Future<void> getAddress(
      {required Function(List<Address>) onSuccess,
      required Function(String) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };

      http.Response response =
          await HttpRequest.get(Uri.parse(Api.getAddressUrl), headers: headers);
      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        var addressList = addressListFromJson(data['data']);
        onSuccess(addressList);
      } else {
        onError(data['message']);
      }
    } catch (e) {
      onError("Sorry something went wrong!!!!.");
    }
  }

  static Future<void> createAddress(
      {required Address address,
      required Function() onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };
      address.country = "Nepal";
      var body = address.toJson();
      print(body);
      http.Response response = await HttpRequest.post(
          Uri.parse(Api.addAddressUrl),
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

  static Future<void> updateAddress(
      {required Address address,
      required Function() onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };
      var body = {"address": address.toJson()};

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.editAddressUrl),
          headers: headers,
          body: json.encode(body));

      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      print(e.toString());
      print(s);
      onError("Something went wrong !!!!");
    }
  }

  static Future<void> deleteAddress(
      {required Address address,
      required Function() onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };
      var body = {"address": address.toJson()};

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.editAddressUrl),
          headers: headers,
          body: json.encode(body));

      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      print(e.toString());
      print(s);
      onError("Something went wrong !!!!");
    }
  }
}
