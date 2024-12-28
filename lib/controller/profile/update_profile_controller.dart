import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepal_excaliber/repo/profile_repo.dart';
import 'package:nepal_excaliber/utils/date_helper.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../models/user.dart';
import '../../widgets/custom-snackbar.dart';
import '../core-controller.dart';

class UpdateProfileController extends GetxController {
  var formKey = GlobalKey<FormState>();
  final coreController = Get.find<CoreController>();

  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
      context: Get.context, barrierDimisable: false);

  final picker = ImagePicker();
  Rx<File?> image = Rxn<File?>();

  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var dobController = TextEditingController();
  var selectedGender = "Male".obs;

  @override
  void onInit() {
    nameController.text = coreController.currentUser.value?.name ?? "";
    usernameController.text = coreController.currentUser.value?.username ?? "";
    emailController.text = coreController.currentUser.value?.email ?? "";
    phoneNumberController.text = coreController.currentUser.value?.phone ?? "";
    selectedGender.value =
        coreController.currentUser.value!.gender!.capitalize!;
    if (coreController.currentUser.value?.dob != null) {
      dobController.text =
          DateHelper.dateFormat(coreController.currentUser.value!.dob!);
    }
    super.onInit();
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

  void pickDate() async {
    // DatePicker.showDatePicker(
    //   Get.context!,
    //   showTitleActions: true,
    //   maxTime: DateTime.now(),
    //   onChanged: (date) {},
    //   onConfirm: (date) {
    //     dobController.text = date.toString().split(" ")[0];
    //   },
    //   currentTime: DateTime.now(),
    //   locale: LocaleType.en,
    // );
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
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
        name: nameController.text,
        gender: selectedGender.value,
      );
      if (dobController.text.isNotEmpty) {
        user.dob = DateTime.parse(dobController.text);
      }
      await ProfileRepo.updateProdile(
        user: user,
        image: base64Image,
        onSuccess: () {
          loading.hide();
          coreController.loadCurrentUser();
          Get.back();
          CustomSnackBar.success(
              title: "Update Profile", message: "Profile updated succesfully");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Update Profile", message: message);
        },
      );
    }
  }
}
