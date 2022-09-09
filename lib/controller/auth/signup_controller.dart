import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepal_excaliber/repo/auth-repo.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../models/user.dart';

class SignupController extends GetxController {
  var formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  Rx<File?> image = Rxn<File?>();

  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
      context: Get.context, barrierDimisable: false);
  var passwordObscure = true.obs;
  var confirmPasswordObscure = false.obs;
  var selectedGender = "Male".obs;

  var usernameController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  void onEyeClick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void onConfirmEyeClick() {
    confirmPasswordObscure.value = !confirmPasswordObscure.value;
  }

  void getImage() async {
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 500,
        maxWidth: 500);

    if (pickedImage != null) {
      image.value = File(pickedImage.path);
    }
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        CustomSnackBar.info(
            title: "Invalid Password", message: "Password do not match!!!");
      }
      loading.show(message: "signing up ...");
      String? base64Image;
      if (image.value != null) {
        final bytes = File(image.value!.path).readAsBytesSync();
        base64Image = base64Encode(bytes);
      }
      User user = User(
        username: usernameController.text,
        email: emailController.text,
        phone: phoneNumberController.text,
        name: "${firstNameController.text} ${lastNameController.text}",
        gender: selectedGender.value,
      );
      await AuthRepo.signup(
          user: user,
          password: passwordController.text,
          image: base64Image,
          onSuccess: () {
            loading.hide();
            Get.back();
            CustomSnackBar.success(title: "Sign up succesful");
          },
          onError: (message) {
            loading.hide();
            CustomSnackBar.error(title: "Signup", message: message);
          });
    }
  }
}
