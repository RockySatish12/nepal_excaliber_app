import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/profile/address-form-controller.dart';
import 'package:nepal_excaliber/utils/colors.dart';

import '../../utils/validators.dart';
import '../../widgets/custom-text-field.dart';

class AddressFormScreen extends StatelessWidget {
  static const String routeName = "/address-form";
  final c = Get.find<AddressFormController>();
  AddressFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address Form"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: c.formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Column(
              children: [
                CustomTextField(
                  controller: c.labelController,
                  validator: Validators.checkFieldEmpty,
                  prefixIcon: const Icon(
                    Icons.location_city_outlined,
                    size: 20,
                    color: AppColors.hintTextColor,
                  ),
                  hint: "Label (eg: Home)",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: c.nameController,
                  validator: Validators.checkFieldEmpty,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    size: 20,
                  ),
                  hint: "Contact Name",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: c.contactController,
                  validator: Validators.checkFieldEmpty,
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    size: 20,
                  ),
                  hint: "Contact",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: c.provisionController,
                  validator: Validators.checkFieldEmpty,
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  hint: "Provision (eg: Gandaki Provision)",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: c.districtController,
                  validator: Validators.checkFieldEmpty,
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  hint: "District (eg: Kaski)",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: c.cityController,
                  validator: Validators.checkFieldEmpty,
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  hint: "City (eg: Pokhara)",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: c.areaController,
                  validator: Validators.checkFieldEmpty,
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  hint: "Area (eg: New-road)",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: c.streetController,
                  validator: Validators.checkFieldEmpty,
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  hint: "Street (eg: Pragati Marg)",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    controller: c.zipController,
                    validator: Validators.checkFieldEmpty,
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                    ),
                    hint: "Zip Code (eg: 33700)",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size.fromHeight(36)),
                  onPressed: () {
                    c.isUpdate.value ? c.updateAddress() : c.submit();
                  },
                  child: Text(
                    c.isUpdate.value ? "Update" : "Submit",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          color: AppColors.secondaryColor,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
