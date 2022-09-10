import 'package:get/get.dart';
import 'package:nepal_excaliber/models/address.dart';
import 'package:nepal_excaliber/repo/address-repo.dart';
import 'package:nepal_excaliber/screens/profile/address-form.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class SavedAddressController extends GetxController {
  RxList<Address> address = RxList<Address>();
  RxBool loadingData = RxBool(false);
  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
      context: Get.context, barrierDimisable: false);

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

  void deleteAddress(int index) {
    loading.show(message: "Please wait ..");
    AddressRepo.deleteAddress(
      address: address[index],
      onSuccess: () {
        loading.hide();
        address.removeAt(index);
        CustomSnackBar.info(title: "Address", message: "Address removed");
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Address", message: message);
      },
    );
  }

  void gotoAddressForm() {
    Get.toNamed(AddressFormScreen.routeName, arguments: [false]);
  }
}
