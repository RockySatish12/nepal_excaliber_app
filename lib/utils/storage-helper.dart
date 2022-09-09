import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:nepal_excaliber/models/access-token.dart';

import '../models/user.dart';
import 'storage-keys.dart';

class StorageHelper {
  static AccessToken? getToken() {
    try {
      final box = GetStorage();
      AccessToken token = AccessToken.fromJson(
          jsonDecode(box.read(StorageKeys.ACCESS_TOKEN)) ?? "");
      return token;
    } catch (e, s) {
      return null;
    }
  }

  static User? getUser() {
    try {
      final box = GetStorage();
      User user = User.fromJson(box.read(StorageKeys.USER));
      return user;
    } catch (e, s) {
      return null;
    }
  }
}
