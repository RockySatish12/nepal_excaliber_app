import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/core-controller.dart';
import 'package:nepal_excaliber/models/cart.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';

import '../../models/product.dart';

class CartController extends GetxController {
  final coreController = Get.find<CoreController>();
  RxBool loading = RxBool(false);
  RxList<Cart> cartsItems = RxList<Cart>();
  RxDouble totalCost = RxDouble(0);
  RxDouble totalDiscount = RxDouble(0);
  RxDouble grandTotal = RxDouble(0);

  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    loadCartItems();
    super.onInit();
  }

  void scrollToEnd() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void addToCart(
      {required Product product,
      required String color,
      required String size,
      required int quantity}) async {
    var fetchedCart = await coreController.databaseHelper.getCartItem(
        "product_id = ? AND color = ? AND sizes = ?",
        [product.id!.toString(), color, size]);
    log(fetchedCart.toString());
    if (fetchedCart != null) {
      fetchedCart.quantity!.value += quantity;
      fetchedCart.hasOffer = product.hasOffer;
      fetchedCart.productPrice = product.price;
      fetchedCart.discount = product.discount;
      coreController.databaseHelper.updateCartItem(fetchedCart);
    } else {
      var cart = Cart(
        productId: product.id!,
        productTitle: product.title,
        productPrice: product.price!,
        hasOffer: product.hasOffer,
        discount: product.discount,
        category: product.category!.title,
        imageUrl: product.imageUrl,
        quantity: RxInt(quantity),
        color: color,
        sizes: size,
      );
      log(cart.toJson().toString());
      await coreController.databaseHelper.saveToCart(cart);
    }
    CustomSnackBar.success(message: "Added to Cart");
    loadCartItems();
  }

  void loadCartItems() async {
    loading.value = true;
    cartsItems.clear();
    cartsItems.addAll(await coreController.databaseHelper.getCartItems());
    log(cartsItems.map((element) => element.toJson()).toList().toString());
    loading.value = false;
    calculateTotal();
  }

  void increment(Cart cart) async {
    cart.quantity!.value++;
    await coreController.databaseHelper.updateCartItem(cart);
    // loadCartItems();
    calculateTotal();
  }

  void decrement(Cart cart) async {
    cart.quantity!.value--;
    if (cart.quantity!.value == 0) {
      removeItem(cart);
    } else {
      await coreController.databaseHelper.updateCartItem(cart);
    }
    // loadCartItems();
    calculateTotal();
  }

  void removeItem(Cart cart) async {
    if (await coreController.databaseHelper.delete(cart.id!)) {
      cartsItems.removeWhere((element) => element.id == cart.id);
      CustomSnackBar.success(
          title: "Remove item", message: "Item removed from cart");
    } else {
      CustomSnackBar.error(
          title: "Remove item", message: "Failed to remove item from cart");
    }
    calculateTotal();
  }

  void calculateTotal() {
    for (var cartItem in cartsItems) {
      totalCost.value += cartItem.productPrice!;
      totalDiscount.value +=
          getDiscountPrice(cartItem.discount!, cartItem.productPrice!);
    }
    grandTotal.value = totalCost.value - totalDiscount.value;
  }

  double getDiscountPrice(int discount, num price) {
    return ((discount / 100) * price);
  }
}
