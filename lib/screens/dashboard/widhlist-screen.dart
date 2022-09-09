import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/wishlist-screen-controller.dart';
import 'package:nepal_excaliber/utils/imagePaths.dart';
import 'package:nepal_excaliber/widgets/empty_widget.dart';
import 'package:nepal_excaliber/widgets/product-item-tile.dart';
import 'package:nepal_excaliber/widgets/shirmmer-layout.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({Key? key}) : super(key: key);

  static const routeName = "/wishlist";
  final c = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Obx(
            () => (c.products.isEmpty)
                ? const EmptyScreen(
                    image: ImagePath.WISHLIST,
                    title: "Your wishlist is empty",
                    message:
                        "Looks like you haven't added anything to your wishlist. Go ahead & expolre categories",
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: c.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductItemTile(
                        product: c.products[index],
                        showAddCart: true,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
