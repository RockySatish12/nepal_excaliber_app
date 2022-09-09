import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/core-controller.dart';
import 'package:nepal_excaliber/controller/profile/update_profile_controller.dart';

import '../../utils/colors.dart';
import '../../utils/imagePaths.dart';
import '../../utils/validators.dart';
import '../../widgets/custom-text-field.dart';
import '../../widgets/custom_radio_widget.dart';

class UpdateProfileScreen extends StatelessWidget {
  static const routeName = "/update-profile";
  final c = Get.find<UpdateProfileController>();
  final coreController = Get.find<CoreController>();
  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: (c.image.value != null)
                      ? Image.file(
                          c.image.value!,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              coreController.currentUser.value?.imageUrl ?? "",
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(
                            ImagePath.AVATAR_UPLOAD,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            InkWell(
              onTap: c.getImage,
              child: Text(
                "Change Cover",
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.colorScheme.tertiary),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Form(
              key: c.formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: c.usernameController,
                      validator: Validators.checkFieldEmpty,
                      prefixIcon: const Icon(
                        Icons.person_outline_outlined,
                        size: 20,
                      ),
                      hint: "Username",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: c.nameController,
                      validator: Validators.checkFieldEmpty,
                      prefixIcon: const Icon(
                        Icons.person_outline_outlined,
                        size: 20,
                      ),
                      hint: "Name",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: c.emailController,
                      validator: Validators.checkEmailField,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        size: 20,
                      ),
                      hint: "Email",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: c.phoneNumberController,
                      validator: Validators.checkPhoneField,
                      prefixIcon: const Icon(
                        Icons.phone_outlined,
                        size: 20,
                      ),
                      hint: "Phone Number",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      readOnly: true,
                      onTap: (c.pickDate),
                      controller: c.dobController,
                      validator: Validators.checkFieldEmpty,
                      prefixIcon: const Icon(
                        Icons.date_range_outlined,
                        size: 20,
                      ),
                      hint: "DOB",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Gender",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRadioWidget(
                            title: "Male",
                            value: "Male",
                            groupValue: c.selectedGender.value,
                            onChange: (val) {
                              c.selectedGender.value = "Male";
                            },
                          ),
                          CustomRadioWidget(
                            title: "Female",
                            value: "Female",
                            groupValue: c.selectedGender.value,
                            onChange: (val) {
                              c.selectedGender.value = "Female";
                            },
                          ),
                          CustomRadioWidget(
                            title: "Others",
                            value: "Others",
                            groupValue: c.selectedGender.value,
                            onChange: (val) {
                              c.selectedGender.value = "Others";
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          minimumSize: const Size.fromHeight(36)),
                      onPressed: () {
                        c.submit();
                      },
                      child: Text(
                        "Submit",
                        style: theme.textTheme.bodyLarge!.copyWith(
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
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
