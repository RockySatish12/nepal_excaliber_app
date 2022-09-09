import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_excaliber/controller/core-controller.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';

class HttpRequest {
  static Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body}) async {
    try {
      http.Response response =
          await http.post(url, headers: headers, body: body);

      if (response.statusCode == 401) {
        sessionExpired();
      }
      return response;
    } catch (e, s) {
      print(e);
      print(s);
      log(s.toString());
      throw "Server Error";
    }
  }

  static Future<http.Response> get(Uri url,
      {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 401) {
        sessionExpired();
      }
      return response;
    } catch (e) {
      throw "Server Error";
    }
  }

  static sessionExpired() {
    var c = Get.find<CoreController>();
    if (!c.isUserLoggedIn()) return;
    c.logOut();
    CustomSnackBar.info(
        title: "Sesson Expired",
        message: "Your session has expired. Please login");
  }
}
