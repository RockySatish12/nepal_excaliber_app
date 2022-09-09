import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/wishlist-screen-controller.dart';

import '../models/product.dart';
import '../screens/common/product-detail-screen.dart';
import '../utils/colors.dart';

class ProductItemTile extends StatelessWidget {
  final Product product;
  final bool showAddCart;
  const ProductItemTile({
    Key? key,
    required this.product,
    this.showAddCart = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(ProductDetailScreen.routeName,
            arguments: {"product": product});
      },
      child: Container(
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
                width: 100,
                child: Image.network(
                  product.imageUrl!,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width -
                  (100 + 12 + 12 + 8 + 8 + 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title!,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    product.category!.title!,
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
                        (product.hasOffer!)
                            ? "Rs. ${(product.price! - getDiscountPrice()).toStringAsFixed(2)}"
                            : "Rs. ${(product.price!).toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (product.hasOffer!) ...[
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Rs. ${(product.price!).toStringAsFixed(2)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.hintTextColor),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "SAVE ${product.discount}%",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.tertiaryColor),
                        ),
                      ]
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  if (showAddCart)
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.tertiaryColor,
                            ),
                            label: Text(
                              "Add to Cart",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: AppColors.tertiaryColor,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 1,
                          color: AppColors.borderColor,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton.icon(
                            onPressed: () {
                              Get.find<WishlistController>()
                                  .toogleToWishList(product.id!);
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AppColors.errorColor,
                            ),
                            label: Text(
                              "Remove",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: AppColors.errorColor,
                                  ),
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
      ),
    );
  }

  double getDiscountPrice() {
    return ((product.discount! / 100) * product.price!);
  }
}
