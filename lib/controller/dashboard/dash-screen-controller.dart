import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/cart-controller.dart';

class DashScreenController extends GetxController {
  RxInt currentIndex = RxInt(0);

  var c = Get.find<CartController>();

  void onItemTapped(int index) {
    currentIndex.value = index;
  }
}
