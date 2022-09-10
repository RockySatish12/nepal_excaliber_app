import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/cart-controller.dart';
import 'package:nepal_excaliber/repo/order-repo.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../models/address.dart';
import '../../repo/address-repo.dart';
import '../../utils/config.dart';
import '../../widgets/custom-snackbar.dart';
import '../core-controller.dart';

class DeliveryController extends GetxController {
  final cartController = Get.find<CartController>();
  final coreController = Get.find<CoreController>();

  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
      context: Get.context, barrierDimisable: false);

  RxList<Address> address = RxList<Address>();
  RxBool loadingData = RxBool(false);
  RxInt selectedAddress = RxInt(0);

  @override
  void onInit() {
    loadAddress();
    super.onInit();
  }

  void loadAddress() {
    loadingData.value = true;
    AddressRepo.getAddress(
      onSuccess: (addressList) {
        loadingData.value = false;
        address.clear();
        address.addAll(addressList);
      },
      onError: (message) {
        loadingData.value = false;
        CustomSnackBar.error(title: "Failed to fetch", message: message);
      },
    );
  }

  void makePayment() async {
    try {
      ESewaConfiguration configuration = ESewaConfiguration(
          clientID: Config.clientId,
          secretKey: Config.secretKey,
          environment: Config.eSewaEnv);

      ESewaPnp pnp = ESewaPnp(configuration: configuration);

      ESewaPayment payment = ESewaPayment(
          amount: cartController.grandTotal.value,
          productName:
              "Order Placed ${cartController.cartsItems[0].productTitle}",
          productID: cartController.cartsItems[0].productId!.toString(),
          callBackURL: "https://uashim.com.np");

      try {
        final res = await pnp.initPayment(payment: payment);
        loading.show(message: "Placing order ...");
        await OrderRepo.placeOrder(
            totalCost: res.totalAmount!,
            addressId: address[selectedAddress.value].id.toString(),
            paymentToken: res.referenceId!,
            products: cartController.cartsItems,
            onSuccess: () async {
              loading.hide();
              await coreController.databaseHelper.clearCart();
              cartController.cartsItems.clear();
              Get.back();
              CustomSnackBar.success(
                  title: "Order Placed", message: "Order Succesful");
            },
            onError: (message) {
              loading.hide();
              CustomSnackBar.success(title: "Order", message: message);
            });
      } on ESewaPaymentException catch (e) {
        CustomSnackBar.error(title: "Payment", message: "ESEWA Exception");
      }
    } catch (e, s) {
      CustomSnackBar.error(title: "Payment", message: "Payment Exception");
      print(e);
      print(s);
    }
  }
}
