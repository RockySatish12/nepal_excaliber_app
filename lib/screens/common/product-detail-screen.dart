import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/cart-controller.dart';
import 'package:nepal_excaliber/controller/common/product-detail-controller.dart';
import 'package:nepal_excaliber/models/cart.dart';
import 'package:nepal_excaliber/utils/constants.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';
import '../../models/product.dart';
import '../../utils/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product-detail-screen";
  ProductDetailScreen({Key? key}) : super(key: key);
  final c = Get.find<ProductDetailController>();
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final Product product = Get.arguments['product'];
    c.product.value = product;
    c.checkinWishList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.6,
          iconTheme: const IconThemeData.fallback(),
          backgroundColor: theme.colorScheme.secondary,
          title: SizedBox(
            width: 200,
            child: Text(
              product.title!,
              style: theme.textTheme.titleLarge!.copyWith(
                color: AppColors.textColor,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                Obx(
                  () => (c.checkingWislist.value)
                      ? Center(
                          child: Container(
                              alignment: Alignment.center,
                              width: 150,
                              height: 30,
                              child: const CircularProgressIndicator(
                                color: AppColors.tertiaryColor,
                              )),
                        )
                      : Expanded(
                          child: TextButton.icon(
                            onPressed: c.toogleToWishList,
                            icon: Icon(
                              Icons.favorite_border,
                              color: (c.inWishlist.value)
                                  ? AppColors.errorColor
                                  : AppColors.primaryColor,
                            ),
                            label: Text(
                              (c.inWishlist.value)
                                  ? "Remove from Wishlist"
                                  : "Add to Wishlist",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                  color: (c.inWishlist.value)
                                      ? AppColors.errorColor
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton.icon(
                    onPressed: () async {
                      final cartController = Get.find<CartController>();
                      cartController.addToCart(
                          product: product,
                          color: product.colors![c.selectedColorIndex.value],
                          size: product.sizes![c.selectedSizeIndex.value],
                          quantity: c.productCount.value);
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.tertiaryColor,
                    ),
                    label: Text(
                      "Add to Cart",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.tertiaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...buildProductDetailSection(context),
                const SizedBox(
                  height: 12,
                ),
                const Divider(
                  height: 2,
                  color: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                ...buildProductCartSection(),
                const SizedBox(
                  height: 12,
                ),
                const Divider(
                  height: 2,
                  color: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                ...buildReturnPloicySection(),
                const SizedBox(
                  height: 12,
                ),
                const Divider(
                  height: 2,
                  color: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildColorItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          c.selectedColorIndex.value = index;
        },
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.4),
                blurRadius: 0.2,
                blurStyle: BlurStyle.outer,
              )
            ],
            color: AppColors.hexToColor(
              c.product.value!.colors![index],
            ),
          ),
          child: (c.selectedColorIndex.value == index)
              ? Icon(
                  Icons.check_outlined,
                  color: AppColors.hexToColor(
                    c.product.value!.colors![index],
                  ).withRed(150).withBlue(150),
                )
              : null,
        ),
      ),
    );
  }

  Widget buildSizeItem(int index) {
    var isActive = c.selectedSizeIndex.value == index;
    return InkWell(
      onTap: () {
        c.selectedSizeIndex.value = index;
      },
      child: Container(
        height: 32,
        width: 32,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.4),
              blurRadius: 0.2,
              blurStyle: BlurStyle.outer,
            )
          ],
          color:
              (isActive) ? AppColors.tertiaryColor : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          c.product.value!.sizes![index],
          style: theme.textTheme.bodyLarge!.copyWith(
              color:
                  (isActive) ? AppColors.secondaryColor : AppColors.textColor),
        ),
      ),
    );
  }

  double getDiscountPrice() {
    return ((c.product.value!.discount! / 100) * c.product.value!.price!);
  }

  buildProductDetailSection(BuildContext context) {
    return [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(c.product.value!.imageUrl!),
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      Text(
        c.product.value!.title!,
        style: theme.textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        c.product.value!.description!,
        style:
            theme.textTheme.bodyLarge!.copyWith(color: AppColors.hintTextColor),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        children: [
          Text(
            (c.product.value!.hasOffer!)
                ? "Rs. ${(c.product.value!.price! - getDiscountPrice()).toStringAsFixed(2)}"
                : "Rs. ${(c.product.value!.price!).toStringAsFixed(2)}",
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
          ),
          if (c.product.value!.hasOffer!) ...[
            const SizedBox(
              width: 8,
            ),
            Text(
              "Rs. ${(c.product.value!.price!).toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 20,
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.hintTextColor),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "SAVE ${c.product.value!.discount}%",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20, color: AppColors.tertiaryColor),
            ),
          ]
        ],
      ),
    ];
  }

  buildProductCartSection() {
    return [
      if (c.product.value!.sizes != null) ...[
        Text(
          "Select Size:",
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 32,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: c.product.value!.sizes!.length,
            itemBuilder: (context, index) {
              return Obx(() => buildSizeItem(index));
            },
          ),
        )
      ],
      if (c.product.value!.colors != null) ...[
        const SizedBox(
          height: 18,
        ),
        Text(
          "Select Colors:",
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 32,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: c.product.value!.colors!.length,
            itemBuilder: (context, index) {
              return Obx(() => buildColorItem(index));
            },
          ),
        )
      ],
      const SizedBox(
        height: 18,
      ),
      Text(
        "Quantity",
        style: theme.textTheme.titleMedium,
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (c.productCount.value == 1) {
                  CustomSnackBar.info(
                      title: "Product Count", message: "Cannot be less than 1");
                  return;
                }
                c.productCount.value--;
              },
              icon: const Icon(
                Icons.remove_circle_outline,
                size: 24,
                color: AppColors.hintTextColor,
              ),
            ),
            Obx(
              () => Text(
                c.productCount.value.toString(),
                style: theme.textTheme.bodyLarge!.copyWith(fontSize: 24),
              ),
            ),
            IconButton(
              onPressed: () {
                c.productCount.value++;
              },
              icon: const Icon(
                Icons.add_circle_outline,
                size: 24,
                color: AppColors.tertiaryColor,
              ),
            ),
          ],
        ),
      )
    ];
  }

  buildReturnPloicySection() {
    return [
      Text(
        "Return & Exchange Policy",
        style: theme.textTheme.titleLarge,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        Constants.returnPolicyText,
        style:
            theme.textTheme.bodyLarge!.copyWith(color: AppColors.hintTextColor),
        textAlign: TextAlign.justify,
      ),
    ];
  }
}
