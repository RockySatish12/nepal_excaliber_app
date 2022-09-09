import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/repo/profile_repo.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var oldPasswordObscure = true.obs;
  var newPasswordObscure = true.obs;
  var confirmPasswordObscure = true.obs;

  void onOldEyeClick() {
    oldPasswordObscure.value = !oldPasswordObscure.value;
  }

  void onNewEyeClick() {
    newPasswordObscure.value = !newPasswordObscure.value;
  }

  void onConfirmEyeClick() {
    confirmPasswordObscure.value = !confirmPasswordObscure.value;
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      var oldPassword = oldPasswordController.text;
      var newPassword = newPasswordController.text;
      var confirmPassword = confirmPasswordController.text;
      if (confirmPassword != newPassword) {
        CustomSnackBar.info(
            title: "Passowrd", message: "Please confirm new password");
        newPasswordController.clear();
        confirmPasswordController.clear();
        return;
      }
      loading.show(message: "Please wait ...");
      await ProfileRepo.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          onSuccess: () {
            loading.hide();
            Get.back();
            CustomSnackBar.success(
                title: "Password Changed",
                message: "Password changed succesfully");
          },
          onError: (message) {
            loading.hide();
            CustomSnackBar.info(title: "Passowrd", message: message);
            newPasswordController.clear();
            oldPasswordController.clear();
            confirmPasswordController.clear();
          });
    }
  }
}
