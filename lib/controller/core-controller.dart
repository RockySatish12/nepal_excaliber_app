import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nepal_excaliber/models/user.dart';
import 'package:nepal_excaliber/screens/auth/login_screen.dart';
import 'package:nepal_excaliber/utils/storage-helper.dart';

import '../utils/storage-keys.dart';

class CoreController extends GetxController {
  Rx<User?> currentUser = Rxn<User>();

  @override
  void onInit() {
    loadCurrentUser();
    super.onInit();
  }

  void loadCurrentUser() async {
    currentUser.value = StorageHelper.getUser();
  }

  bool isUserLoggedIn() {
    return currentUser.value != null;
  }

  void logOut() async {
    final box = GetStorage();
    await box.write(StorageKeys.ACCESS_TOKEN, null);
    await box.write(StorageKeys.USER, null);
    loadCurrentUser();
    Get.offAllNamed(LoginScreen.routeName);
  }
}
