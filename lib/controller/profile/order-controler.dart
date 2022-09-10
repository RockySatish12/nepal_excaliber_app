import 'package:get/get.dart';
import 'package:nepal_excaliber/models/order.dart';
import 'package:nepal_excaliber/repo/order-repo.dart';

class OrderScreenControler extends GetxController {
  RxList<OrderItems> orders = RxList();
  RxBool isLoading = false.obs;

  @override
  onInit() {
    loadData();
    super.onInit();
  }

  loadData() async {
    isLoading.value = true;
    OrderRepo.getOrder(
      onSuccess: (orderList) {
        isLoading.value = false;
        orders.clear();
        orders.addAll(orderList);
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }
}
