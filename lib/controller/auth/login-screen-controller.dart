import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/repo/auth-repo.dart';
import 'package:nepal_excaliber/screens/dashboard/dash-screen.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginScreenController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var passwordObscure = true.obs;
  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  void onEyeClick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "logging....");
      await AuthRepo.loginUser(
        email: emailTextController.text,
        password: passwordTextController.text,
        onSuccess: () {
          Get.offAndToNamed(DashScreen.routeName);
          CustomSnackBar.success(
              title: "Login Successful", message: "Logged in succesfully");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(message: message, title: "Login");
        },
      );
    }
  }
}
