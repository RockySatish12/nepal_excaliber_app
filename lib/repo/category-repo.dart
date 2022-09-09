import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../utils/api.dart';
import '../utils/http-request.dart';
import '../utils/storage-helper.dart';

class CategoryRepo {
  Future<void> getCategories(
      {required Function(List<Category>) onSuccess,
      required Function(String) onError}) async {
    try {
      var token = StorageHelper.getToken()!;
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "${token.type} ${token.token!}"
      };

      http.Response response = await HttpRequest.get(
          Uri.parse(Api.allCategoryUrl),
          headers: headers);
      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        var categories = categoriesFromJson(data['data']);
        onSuccess(categories);
      } else {
        onError(data['message']);
      }
    } catch (e) {
      onError("Sorry something went wrong!!!!.");
    }
  }
}
