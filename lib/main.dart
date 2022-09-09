import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nepal_excaliber/controller/dashboard/cart-controller.dart';
import 'package:nepal_excaliber/controller/dashboard/category-controller.dart';
import 'package:nepal_excaliber/controller/core-controller.dart';
import 'package:nepal_excaliber/controller/dashboard/dash-screen-controller.dart';
import 'package:nepal_excaliber/controller/dashboard/home-view-controller.dart';
import 'package:nepal_excaliber/controller/auth/login-screen-controller.dart';
import 'package:nepal_excaliber/controller/common/product-detail-controller.dart';
import 'package:nepal_excaliber/controller/common/products-screen-controller.dart';
import 'package:nepal_excaliber/controller/dashboard/profile_view_controller.dart';
import 'package:nepal_excaliber/controller/auth/signup_controller.dart';
import 'package:nepal_excaliber/controller/dashboard/wishlist-screen-controller.dart';
import 'package:nepal_excaliber/controller/profile/change_password_controller.dart';
import 'package:nepal_excaliber/controller/profile/saved_address_controller.dart';
import 'package:nepal_excaliber/controller/profile/update_profile_controller.dart';
import 'package:nepal_excaliber/screens/dashboard/dash-screen.dart';
import 'package:nepal_excaliber/screens/common/product-detail-screen.dart';
import 'package:nepal_excaliber/screens/common/products-screen.dart';
import 'package:nepal_excaliber/screens/auth/signup_screen.dart';
import 'package:nepal_excaliber/screens/profile/change_password_screen.dart';
import 'package:nepal_excaliber/screens/profile/saved_address.dart';
import 'package:nepal_excaliber/screens/profile/update_profile_screen.dart';

import 'screens/auth/login_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      initialRoute: SplashScreen.routeName,
      initialBinding: BindingsBuilder(
        () {
          Get.put(CoreController());
        },
      ),
      getPages: [
        GetPage(
          name: SplashScreen.routeName,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => LoginScreen(),
          binding: BindingsBuilder(
              (() => Get.lazyPut(() => LoginScreenController()))),
        ),
        GetPage(
          name: SignupScreen.routeName,
          page: () => SignupScreen(),
          binding:
              BindingsBuilder((() => Get.lazyPut(() => SignupController()))),
        ),
        GetPage(
          name: DashScreen.routeName,
          page: () => DashScreen(),
          binding: BindingsBuilder((() {
            Get.lazyPut(() => DashScreenController());
            Get.lazyPut(() => WishlistController());
            Get.lazyPut(() => HomeViewController());
            Get.lazyPut(() => CategoryViewController());
            Get.lazyPut(() => CartController());
            Get.lazyPut(() => ProfileController());
          })),
        ),
        GetPage(
          name: ProductScreen.routeName,
          page: () => ProductScreen(),
          binding: BindingsBuilder(
            (() => Get.lazyPut(
                  () => ProductScreenController(),
                )),
          ),
        ),
        GetPage(
          name: ProductDetailScreen.routeName,
          page: () => ProductDetailScreen(),
          binding: BindingsBuilder(
            (() => Get.lazyPut(
                  () => ProductDetailController(),
                )),
          ),
        ),
        GetPage(
          name: ChangePasswordScreen.routeName,
          page: () => ChangePasswordScreen(),
          binding: BindingsBuilder(
            (() => Get.lazyPut(
                  () => ChangePasswordController(),
                )),
          ),
        ),
        GetPage(
          name: UpdateProfileScreen.routeName,
          page: () => UpdateProfileScreen(),
          binding: BindingsBuilder(
            (() => Get.lazyPut(
                  () => UpdateProfileController(),
                )),
          ),
        ),
        GetPage(
          name: SavedAddressScreen.routeName,
          page: () => SavedAddressScreen(),
          binding: BindingsBuilder(
            (() => Get.lazyPut(
                  () => SavedAddressController(),
                )),
          ),
        ),
      ],
    );
  }
}
