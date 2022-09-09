import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/screens/dashboard/dash-screen.dart';

import '../controller/core-controller.dart';
import '../utils/imagePaths.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final c = Get.find<CoreController>();
    Timer(const Duration(seconds: 3), () {
      if (c.isUserLoggedIn()) {
        Get.offAndToNamed(DashScreen.routeName);
      } else {
        Get.offAndToNamed(LoginScreen.routeName);
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
            child: SvgPicture.asset(
          ImagePath.LOGO,
          fit: BoxFit.contain,
        )),
      ),
    );
  }
}
