import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/screens/common/product-detail-screen.dart';

import '../models/product.dart';
import '../utils/colors.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(ProductDetailScreen.routeName,
            arguments: {"product": product});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              margin: const EdgeInsets.only(top: 12),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(product.imageUrl!)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 4,
              ),
              child: Row(
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.hintTextColor),
                    )
                  ]
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
