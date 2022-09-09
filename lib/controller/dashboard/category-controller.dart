import 'package:get/get.dart';
import 'package:nepal_excaliber/models/category.dart';
import 'package:nepal_excaliber/repo/category-repo.dart';

class CategoryViewController extends GetxController {
  RxList<Category> categories = RxList<Category>();
  RxBool loading = false.obs;
  final CategoryRepo _categoryRepo = CategoryRepo();

  @override
  onInit() {
    loadLatestProducts();
    super.onInit();
  }

  loadLatestProducts() async {
    loading.value = true;
    categories.clear();
    await _categoryRepo.getCategories(onSuccess: (categoryList) {
      categories.addAll(categoryList);
      loading.value = false;
    }, onError: (message) {
      loading.value = false;
    });
  }
}
