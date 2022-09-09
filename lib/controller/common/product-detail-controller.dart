import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/wishlist-screen-controller.dart';
import 'package:nepal_excaliber/repo/product-repo.dart';

import '../../models/product.dart';

class ProductDetailController extends GetxController {
  final wishlistController = Get.find<WishlistController>();
  Rx<Product?> product = Rxn();
  RxInt selectedSizeIndex = 0.obs;
  RxInt selectedColorIndex = 0.obs;
  RxInt productCount = 1.obs;
  RxBool checkingWislist = false.obs;
  RxBool inWishlist = false.obs;

  final _productRepo = ProductRepo();

  checkinWishList() async {
    checkingWislist.value = true;
    inWishlist.value = await _productRepo.checkInWishList(product.value!.id!);
    checkingWislist.value = false;
  }

  toogleToWishList() async {
    checkingWislist.value = true;
    inWishlist.value = await _productRepo.toogleToWishList(
        product.value!.id!, inWishlist.value);
    wishlistController.loadProducts();
    checkingWislist.value = false;
  }
}
