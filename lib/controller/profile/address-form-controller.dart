import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/profile/saved_address_controller.dart';
import 'package:nepal_excaliber/models/address.dart';
import 'package:nepal_excaliber/repo/address-repo.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddressFormController extends GetxController {
  final c = Get.find<SavedAddressController>();
  var formKey = GlobalKey<FormState>();
  RxBool isUpdate = RxBool(false);
  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
      context: Get.context, barrierDimisable: false);

  late Address address;
  var labelController = TextEditingController();
  var nameController = TextEditingController();
  var contactController = TextEditingController();
  var provisionController = TextEditingController();
  var districtController = TextEditingController();
  var cityController = TextEditingController();
  var areaController = TextEditingController();
  var streetController = TextEditingController();
  var zipController = TextEditingController();

  @override
  void onInit() {
    handleData();
    super.onInit();
  }

  void handleData() {
    var arguments = Get.arguments;
    isUpdate.value = arguments[0];
    if (isUpdate.value) {
      address = arguments[1];
      labelController.text = address.label!;
      nameController.text = address.contactName!;
      contactController.text = address.contact!;
      provisionController.text = address.provision!;
      districtController.text = address.district!;
      cityController.text = address.city!;
      areaController.text = address.area!;
      streetController.text = address.street!;
      zipController.text = address.zipCode!;
    } else {
      address = Address(country: "Nepal");
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      loading.show(message: "Please wiat...");

      address.label = labelController.text;
      address.contactName = nameController.text;
      address.contact = contactController.text;
      address.provision = provisionController.text;
      address.district = districtController.text;
      address.city = cityController.text;
      address.area = areaController.text;
      address.street = streetController.text;
      address.zipCode = zipController.text;

      AddressRepo.createAddress(
        address: address,
        onSuccess: () {
          loading.hide();
          c.loadAddress();
          Get.back();
          CustomSnackBar.success(
              title: "Address", message: "Address added succesfully");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(
              title: "Address", message: "Failed to add address");
        },
      );
    }
  }

  void updateAddress() {
    print("Updating");
    if (formKey.currentState!.validate()) {
      loading.show(message: "Please wiat...");

      address.label = labelController.text;
      address.contactName = nameController.text;
      address.contact = contactController.text;
      address.provision = provisionController.text;
      address.district = districtController.text;
      address.city = cityController.text;
      address.area = areaController.text;
      address.street = streetController.text;
      address.zipCode = zipController.text;

      AddressRepo.updateAddress(
        address: address,
        onSuccess: () {
          loading.hide();
          c.loadAddress();
          Get.back();
          CustomSnackBar.success(
              title: "Address", message: "Address updated succesfully");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(
              title: "Address", message: "Failed to update address");
        },
      );
    }
  }
}
