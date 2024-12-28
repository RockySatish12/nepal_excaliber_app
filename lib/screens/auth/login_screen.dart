import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/auth/login-screen-controller.dart';
import 'package:nepal_excaliber/screens/auth/signup_screen.dart';
import 'package:nepal_excaliber/utils/validators.dart';

import '../../utils/colors.dart';
import '../../utils/imagePaths.dart';
import '../../widgets/custom-text-field.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";
  LoginScreen({Key? key}) : super(key: key);

  final c = Get.find<LoginScreenController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: c.formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 25),
            height: size.height - 25,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    ImagePath.LOGO,
                    height: 80,
                    width: size.width - 24,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login Now",
                          style: theme.textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Please enter following details to continue",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: AppColors.hintTextColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: c.emailTextController,
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
                        Obx(
                          () => CustomTextField(
                            controller: c.passwordTextController,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forget Password?",
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: AppColors.tertiaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              minimumSize: const Size.fromHeight(36)),
                          onPressed: c.onSubmit,
                          child: Text(
                            "Log in",
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
                              "Don't have an account? ",
                              style: theme.textTheme.bodySmall,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(SignupScreen.routeName);
                              },
                              child: Text(
                                "Register",
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: AppColors.tertiaryColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
