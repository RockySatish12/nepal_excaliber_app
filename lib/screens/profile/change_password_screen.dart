import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/profile/change_password_controller.dart';

import '../../utils/colors.dart';
import '../../utils/imagePaths.dart';
import '../../utils/validators.dart';
import '../../widgets/custom-text-field.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = "/change-password";
  final c = Get.find<ChangePasswordController>();
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Form(
        key: c.formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            children: [
              Obx(
                () => CustomTextField(
                  controller: c.oldPasswordController,
                  validator: Validators.checkPasswordField,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    size: 16,
                  ),
                  suffixIcon: InkWell(
                    onTap: c.onOldEyeClick,
                    child: SvgPicture.asset(
                      c.oldPasswordObscure.value
                          ? ImagePath.EYE
                          : ImagePath.EYE_OFF,
                      color: AppColors.textColor,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  obscure: c.oldPasswordObscure.value,
                  hint: "Current Password",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => CustomTextField(
                  controller: c.newPasswordController,
                  validator: Validators.checkPasswordField,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    size: 16,
                  ),
                  suffixIcon: InkWell(
                    onTap: c.onNewEyeClick,
                    child: SvgPicture.asset(
                      c.newPasswordObscure.value
                          ? ImagePath.EYE
                          : ImagePath.EYE_OFF,
                      color: AppColors.textColor,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  obscure: c.newPasswordObscure.value,
                  hint: "New Password",
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
                    onTap: c.onConfirmEyeClick,
                    child: SvgPicture.asset(
                      c.confirmPasswordObscure.value
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
                  "Submit",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
