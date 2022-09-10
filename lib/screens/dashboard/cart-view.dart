import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/cart-controller.dart';
import 'package:nepal_excaliber/models/cart.dart';
import 'package:nepal_excaliber/screens/common/delivery_screen.dart';
import 'package:nepal_excaliber/utils/imagePaths.dart';
import 'package:nepal_excaliber/widgets/cart-item.dart';
import 'package:nepal_excaliber/widgets/empty_widget.dart';

import '../../utils/colors.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);
  final c = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: double.infinity,
          height: (c.cartsItems.isEmpty) ? 0 : 56,
          color: AppColors.secondaryColor,
          duration: const Duration(microseconds: 300),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "Rs ${(c.totalCost.value - c.totalDiscount.value).toStringAsFixed(2)}",
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: c.scrollToEnd,
                    child: Text(
                      "View Details",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.tertiaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.tertiaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      minimumSize: const Size.fromHeight(30)),
                  onPressed: () {
                    Get.toNamed(DeliveryScreen.routeName);
                  },
                  child: Text(
                    "Place Order",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 12, bottom: 8),
          child: Obx(
            () => (c.cartsItems.isEmpty)
                ? const EmptyScreen(
                    image: ImagePath.ADD_TO_CART,
                    title: "Your cart is Empty",
                    message:
                        "Looks like you haven't added anything to your cart. Go ahead & expolre throught different categories",
                  )
                : SingleChildScrollView(
                    controller: c.scrollController,
                    child: Column(
                      children: [
                        StreamBuilder<List<Cart>>(
                            stream: null,
                            builder: (context, snapshot) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: c.cartsItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CartItem(cart: c.cartsItems[index]);
                                },
                              );
                            }),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.secondaryColor),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Sub-total",
                                    style: theme.textTheme.bodyLarge,
                                  )),
                                  Obx(() => Text(
                                        "Rs ${c.totalCost.value.toStringAsFixed(2)}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                                color: AppColors.hintTextColor),
                                      ))
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Discount",
                                    style: theme.textTheme.bodyLarge,
                                  )),
                                  Obx(() => Text(
                                        "Rs ${c.totalDiscount.value.toStringAsFixed(2)}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                                color: AppColors.errorColor),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Grand-total",
                                    style: theme.textTheme.bodyLarge,
                                  )),
                                  Obx(() => Text(
                                        "Rs ${(c.totalCost.value - c.totalDiscount.value).toStringAsFixed(2)}",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                                color: AppColors.tertiaryColor),
                                      )),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
