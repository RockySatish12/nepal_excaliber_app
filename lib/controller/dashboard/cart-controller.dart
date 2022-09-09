import 'dart:developer';

import 'package:get/get.dart';
import 'package:nepal_excaliber/models/cart.dart';
import 'package:nepal_excaliber/utils/db_helper.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';

import '../../models/product.dart';

class CartController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper();
  RxBool loading = RxBool(false);
  RxList<Cart> cartsItems = RxList<Cart>();

  @override
  void onInit() async {
    await databaseHelper.getDb();
    loadCartItems();
    super.onInit();
  }

  void addToCart(
      {required Product product,
      required String color,
      required String size,
      required int quantity}) async {
    var fetchedCart = await databaseHelper.getCartItem(
        "product_id = ? AND color = ? AND sizes = ?",
        [product.id!.toString(), color, size]);
    log(fetchedCart.toString());
    if (fetchedCart != null) {
      fetchedCart.quantity!.value += quantity;
      fetchedCart.hasOffer = product.hasOffer;
      fetchedCart.productPrice = product.price;
      fetchedCart.discount = product.discount;
      databaseHelper.updateCartItem(fetchedCart);
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
      await databaseHelper.saveToCart(cart);
    }
    CustomSnackBar.success(message: "Added to Cart");
    loadCartItems();
  }

  void loadCartItems() async {
    loading.value = true;
    cartsItems.clear();
    cartsItems.addAll(await databaseHelper.getCartItems());
    log(cartsItems.map((element) => element.toJson()).toList().toString());
    loading.value = false;
  }

  void increment(Cart cart) async {
    cart.quantity!.value++;
    await databaseHelper.updateCartItem(cart);
    // loadCartItems();
  }

  void decrement(Cart cart) async {
    cart.quantity!.value--;
    if (cart.quantity!.value == 0) {
      removeItem(cart);
    } else {
      await databaseHelper.updateCartItem(cart);
    }
    // loadCartItems();
  }

  void removeItem(Cart cart) async {
    if (await databaseHelper.delete(cart.id!)) {
      cartsItems.removeWhere((element) => element.id == cart.id);
      CustomSnackBar.success(
          title: "Remove item", message: "Item removed from cart");
    } else {
      CustomSnackBar.error(
          title: "Remove item", message: "Failed to remove item from cart");
    }
  }
}
