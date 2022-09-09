import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../utils/api.dart';
import '../utils/http-request.dart';
import '../utils/storage-helper.dart';
import '../utils/storage-keys.dart';

class ProfileRepo {
  static Future<void> changePassword(
      {required String oldPassword,
      required String newPassword,
      required Function() onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };
      var body = {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };
      http.Response response = await HttpRequest.post(
          Uri.parse(Api.changePasswordUrl),
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

  static Future<void> updateProdile(
      {required User user,
      String? image,
      required Function() onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };
      var body = {
        "name": user.name,
        "username": user.username,
        "phone": user.phone,
        "email": user.email,
        "userType": "User",
        "gender": user.gender,
        "dob": user.dob.toString()
      };
      if (image != null) {
        body['image'] = image;
      }
      http.Response response = await HttpRequest.post(
          Uri.parse(Api.updateProfileUrl),
          headers: headers,
          body: json.encode(body));

      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        final box = GetStorage();
        await box.write(
            StorageKeys.ACCESS_TOKEN, json.encode(data["data"]["accessToken"]));
        await box.write(StorageKeys.USER, data["data"]["user"]);
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      print(e);
      print(s);
      onError("Something went wrong !!!!");
    }
  }
}
