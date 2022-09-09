import 'package:get/get.dart';
import 'package:nepal_excaliber/models/product.dart';
import 'package:nepal_excaliber/repo/product-repo.dart';

class HomeViewController extends GetxController {
  final ProductRepo _productRepo = ProductRepo();

  RxList<Product> latestProduct = RxList<Product>();
  RxList<Product> featuredProduct = RxList<Product>();
  RxBool latestProductLoading = false.obs;
  RxBool styleProductsLoading = false.obs;
  int featuredProductPage = 1;
  bool hasNextPageFeature = true;
  RxList<String> bannerImages = RxList([
    "https://res.cloudinary.com/du7pn6pke/image/upload/v1662703881/nepal%20excaliber/big-sale_pcj7hr.jpg",
    "https://res.cloudinary.com/du7pn6pke/image/upload/v1662703553/nepal%20excaliber/ecommerce-banner_c7gzvg.jpg"
  ]);

  RxInt styleSectionIndex = RxInt(0);

  @override
  onInit() {
    loadLatestProducts();
    loadFeaturedProducts();
    super.onInit();
  }

  loadLatestProducts() async {
    latestProductLoading.value = true;
    latestProduct.clear();
    await _productRepo.getLatestProduct(
      page: 1,
      limit: 5,
      onSuccess: (productsList, hasNextPage) {
        latestProduct.addAll(productsList);
        latestProductLoading.value = false;
      },
      onError: (message) {
        latestProductLoading.value = false;
      },
    );
  }

  loadFeaturedProducts() async {
    if (hasNextPageFeature) {
      await _productRepo.getFeaturedProduct(
        page: featuredProductPage,
        onSuccess: (productList, hasNextPage) {
          featuredProduct.addAll(productList);
          if (hasNextPage) {
            featuredProductPage++;
          } else {
            hasNextPageFeature = false;
          }
        },
        onError: (message) {},
      );
    }
  }
}
