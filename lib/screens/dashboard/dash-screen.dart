import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/core-controller.dart';
import 'package:nepal_excaliber/controller/dashboard/dash-screen-controller.dart';
import 'package:nepal_excaliber/screens/dashboard/cart-view.dart';
import 'package:nepal_excaliber/screens/dashboard/category-view.dart';
import 'package:nepal_excaliber/screens/dashboard/home-view-content.dart';
import 'package:nepal_excaliber/screens/dashboard/profile_view.dart';
import 'package:nepal_excaliber/screens/dashboard/widhlist-screen.dart';
import 'package:nepal_excaliber/utils/colors.dart';
import 'package:nepal_excaliber/utils/imagePaths.dart';

class DashScreen extends StatelessWidget {
  static const routeName = '/dash-screen';
  DashScreen({Key? key}) : super(key: key);

  final c = Get.find<DashScreenController>();
  final coreController = Get.find<CoreController>();

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeViewContent(),
      CategoryContentView(),
      CartView(),
      WishlistScreen(),
      ProfileView()
    ];
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: AppColors.backGroundColor,
        iconTheme: const IconThemeData.fallback(),
        title: SvgPicture.asset(
          ImagePath.LOGO,
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: CachedNetworkImage(
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
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Hello, ${coreController.currentUser.value!.name?.capitalize}",
                    style: theme.textTheme.bodyLarge!.copyWith(fontSize: 20),
                  )
                ],
              ),
            ),
            buildDarwerItem(Icons.home_outlined, "Home", 0),
            buildDarwerItem(Icons.dashboard_outlined, "Category", 1),
            buildDarwerItem(Icons.shopping_cart_outlined, "Cart", 2),
            buildDarwerItem(Icons.favorite_border_outlined, "Wishlist", 3),
            buildDarwerItem(Icons.person_outline, "Profile", 4),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
      body: Obx(() => pages[c.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: AppColors.secondaryColor,
          selectedIconTheme:
              const IconThemeData(color: AppColors.tertiaryColor),
          selectedItemColor: AppColors.tertiaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: c.currentIndex.value,
          onTap: c.onItemTapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined), label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined), label: "Wishlist"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
          ],
        ),
      ),
    );
  }

  Widget buildDarwerItem(IconData iconData, String title, int index) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              c.currentIndex.value = index;
              Get.back();
            },
            leading: Icon(
              iconData,
              color: AppColors.textColor,
            ),
            title: Text(title),
          ),
          const SizedBox(
            height: 4,
          ),
          const Divider()
        ],
      ),
    );
  }
}
