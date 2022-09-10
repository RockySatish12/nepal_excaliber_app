import 'package:get/get.dart';
import 'package:nepal_excaliber/models/category.dart';
import 'package:nepal_excaliber/repo/product-repo.dart';

import '../../models/product.dart';

class ProductScreenController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxBool loadingProducts = RxBool(false);
  final ProductRepo _productRepo = ProductRepo();
  var page = 1;
  var hasNextPage = true;

  loadCategoryProducts(Category category) async {
    loadingProducts.value = true;
    products.clear();
    var data = await _productRepo.getCategoryProducts(category.id!, page);
    products.addAll(data['products']);
    hasNextPage = data['hasNextPage'];
    if (hasNextPage) {
      page++;
    }
    loadingProducts.value = false;
  }

  loadMoreCategoryProducts(Category category) async {
    if (hasNextPage) {
      var data = await _productRepo.getCategoryProducts(category.id!, page);
      products.addAll(data['products']);
      hasNextPage = data['hasNextPage'];
      if (hasNextPage) {
        page++;
      }
    }
  }

  searchProducts({required Category category, required String query}) async {
    if (query.isEmpty) {
      page = 1;
      await loadCategoryProducts(category);
      return;
    }

    loadingProducts.value = true;
    products.clear();
    products.addAll(await _productRepo.searchProducts(
        categoryId: category.id.toString(), query: query));
    loadingProducts.value = false;
  }
}
