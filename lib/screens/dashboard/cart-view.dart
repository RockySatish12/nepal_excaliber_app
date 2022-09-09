import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/cart-controller.dart';
import 'package:nepal_excaliber/models/cart.dart';
import 'package:nepal_excaliber/utils/imagePaths.dart';
import 'package:nepal_excaliber/widgets/cart-item.dart';
import 'package:nepal_excaliber/widgets/empty_widget.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);
  final c = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          child: Obx(
            () => (c.cartsItems.isEmpty)
                ? const EmptyScreen(
                    image: ImagePath.ADD_TO_CART,
                    title: "Your cart is Empty",
                    message:
                        "Looks like you haven't added anything to your cart. Go ahead & expolre throught different categories",
                  )
                : StreamBuilder<List<Cart>>(
                    stream: null,
                    builder: (context, snapshot) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: c.cartsItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CartItem(cart: c.cartsItems[index]);
                        },
                      );
                    }),
          ),
        ),
      ),
    );
  }
}
