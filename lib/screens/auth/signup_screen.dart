import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/auth/signup_controller.dart';

import '../../utils/colors.dart';
import '../../utils/imagePaths.dart';
import '../../utils/validators.dart';
import '../../widgets/custom-text-field.dart';
import '../../widgets/custom_radio_widget.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = "/signup";
  final c = Get.find<SignupController>();
  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24),
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  ImagePath.LOGO,
                  height: 80,
                  width: MediaQuery.of(context).size.width - 24,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Signup",
                style: theme.textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Please fill the form to register",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: AppColors.hintTextColor),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(() => CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: ClipOval(
                      child: SizedBox(
                          height: 120,
                          width: 120,
                          child: (c.image.value != null)
                              ? Image.file(
                                  c.image.value!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(ImagePath.PLACEHOLDER_UPLOAD)),
                    ),
                  )),
              const SizedBox(
                height: 6,
              ),
              InkWell(
                onTap: c.getImage,
                child: Text(
                  "Upload profile",
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.tertiary),
                ),
              ),
              Form(
                key: c.formKey,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
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
                        controller: c.firstNameController,
                        validator: Validators.checkFieldEmpty,
                        prefixIcon: const Icon(
                          Icons.person_outline_outlined,
                          size: 20,
                        ),
                        hint: "Firts Name",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: c.lastNameController,
                        validator: Validators.checkFieldEmpty,
                        prefixIcon: const Icon(
                          Icons.person_outline_outlined,
                          size: 20,
                        ),
                        hint: "Last Name",
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
                        height: 8,
                      ),
                      Obx(
                        () => CustomTextField(
                          controller: c.passwordController,
                          validator: Validators.checkPasswordField,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            size: 16,
                          ),
                          suffixIcon: InkWell(
                            onTap: c.onEyeClick,
                            child: SvgPicture.asset(
                              c.passwordObscure.value
                                  ? ImagePath.EYE
                                  : ImagePath.EYE_OFF,
                              color: AppColors.textColor,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          obscure: c.passwordObscure.value,
                          hint: "Password",
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(
                        () => CustomTextField(
                          controller: c.confirmPasswordController,
                          validator: Validators.checkPasswordField,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            size: 16,
                          ),
                          suffixIcon: InkWell(
                            onTap: c.onEyeClick,
                            child: SvgPicture.asset(
                              c.passwordObscure.value
                                  ? ImagePath.EYE
                                  : ImagePath.EYE_OFF,
                              color: AppColors.textColor,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          obscure: c.confirmPasswordObscure.value,
                          hint: "Confirm Password",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
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
                          "Sign up",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 20,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account? ",
                            style: theme.textTheme.bodySmall,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              "Log in",
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: AppColors.tertiaryColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
