import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';

import '../controller/dashboard/cart-controller.dart';
import '../controller/dashboard/wishlist-screen-controller.dart';
import '../models/cart.dart';
import '../utils/colors.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  final cartController = Get.find<CartController>();
  final wishListCOntroller = Get.find<WishlistController>();
  CartItem({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secondaryColor),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 120,
              child: CachedNetworkImage(
                imageUrl: cart.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.productTitle!,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  cart.category!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.hintTextColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      (cart.hasOffer!)
                          ? "Rs. ${(cart.productPrice)}" //- getDiscountPrice()).toStringAsFixed(2)}
                          : "Rs. ${(cart.productPrice!).toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (cart.hasOffer!) ...[
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Rs. ${(cart.productPrice!).toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.hintTextColor),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "SAVE ${cart.discount}%",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.tertiaryColor),
                      ),
                    ]
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.4),
                            blurRadius: 0.2,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                        color: AppColors.hexToColor(cart.color!),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.4),
                            blurRadius: 0.2,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cart.sizes!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.textColor),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              cartController.decrement(cart);
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              size: 24,
                              color: AppColors.hintTextColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              cart.quantity.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 24),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cartController.increment(cart);
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
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (!wishListCOntroller.products
                            .any((element) => element.id == cart.productId)) {
                          wishListCOntroller.toogleToWishList(cart.productId!);
                          CustomSnackBar.success(
                              title: "Wishlist", message: "Moved to wishlist");
                        } else {
                          CustomSnackBar.info(
                              title: "Wishlist",
                              message: "Already in wishlist");
                        }
                      },
                      child: Text(
                        "Move to wishlist",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.tertiaryColor,
                            ),
                      ),
                    ),
                    Container(
                      height: 12,
                      width: 1,
                      color: AppColors.borderColor,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        cartController.removeItem(cart);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.errorColor,
                      ),
                      label: Text(
                        "Remove",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.errorColor,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
