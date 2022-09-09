import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_excaliber/controller/core-controller.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';

import '../models/user.dart';
import '../utils/api.dart';
import '../utils/http-request.dart';
import '../utils/storage-keys.dart';

class AuthRepo {
  static Future<void> loginUser({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var body = {
        "email": email,
        "password": password,
      };
      http.Response response = await HttpRequest.post(Uri.parse(Api.loginUrl),
          headers: headers, body: json.encode(body));

      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        final box = GetStorage();
        await box.write(
            StorageKeys.ACCESS_TOKEN, json.encode(data["data"]["accessToken"]));
        await box.write(StorageKeys.USER, data["data"]["user"]);
        Get.find<CoreController>().loadCurrentUser();
        onSuccess();
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      onError("Something went wrong");
    }
  }

  static Future<void> signup(
      {required User user,
      required String password,
      String? image,
      required Function onSuccess,
      required Function(String message) onError}) async {
    try {
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var body = {
        "name": user.name,
        "username": user.username,
        "phone": user.phone,
        "email": user.email,
        "password": password,
        "userType": "User",
        "gender": user.gender,
        "image": image
      };

      print(body);

      if (image != null) {
        body['image'] = image;
      }

      http.Response response = await HttpRequest.post(Uri.parse(Api.signupUrl),
          headers: headers, body: json.encode(body));

      dynamic data = jsonDecode(response.body);
      print(Api.signupUrl);
      print(data);
      if (data["status"]) {
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      onError("Something went wrong");
    }
  }
}
