import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/screens/profile/change_password_screen.dart';
import 'package:nepal_excaliber/screens/profile/order-screen.dart';
import 'package:nepal_excaliber/screens/profile/saved_address.dart';
import 'package:nepal_excaliber/screens/profile/update_profile_screen.dart';
import 'package:nepal_excaliber/widgets/profile_tile.dart';

import '../../controller/core-controller.dart';
import '../../controller/dashboard/dash-screen-controller.dart';
import '../../utils/colors.dart';
import '../../utils/imagePaths.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final c = Get.find<DashScreenController>();
  final coreController = Get.find<CoreController>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: coreController.currentUser.value?.imageUrl ?? "",
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
            Text("${coreController.currentUser.value!.name!.capitalize}",
                style: theme.textTheme.titleLarge!),
            ProfileTileWidget(
              onTap: () {
                Get.toNamed(UpdateProfileScreen.routeName);
              },
              iconData: Icons.person_outline,
              title: "Profile",
            ),
            ProfileTileWidget(
                onTap: () {
                  Get.toNamed(ChangePasswordScreen.routeName);
                },
                iconData: Icons.lock_open_outlined,
                title: "Change Password"),
            ProfileTileWidget(
              onTap: () {
                Get.toNamed(OrderScreen.routeName);
              },
              iconData: Icons.gif_box_outlined,
              title: "Orders",
            ),
            ProfileTileWidget(
              onTap: () {
                Get.toNamed(SavedAddressScreen.routeName);
              },
              iconData: Icons.location_on_outlined,
              title: "Saved Address",
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size.fromHeight(36)),
                onPressed: () {
                  coreController.logOut();
                },
                child: Text(
                  "Log out",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
