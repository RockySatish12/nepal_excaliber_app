import 'package:get/get.dart';

import '../../models/product.dart';
import '../../repo/product-repo.dart';

class WishlistController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxBool loadingProducts = RxBool(false);
  final ProductRepo _productRepo = ProductRepo();

  @override
  onInit() {
    loadingProducts.value = true;
    loadProducts();
    super.onInit();
  }

  loadProducts() async {
    products.clear();
    products.addAll(await _productRepo.getWishList());
  }

  toogleToWishList(int productId) async {
    await _productRepo.toogleToWishList(productId, true);
    loadProducts();
  }
}
