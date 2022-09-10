import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/profile/saved_address_controller.dart';
import 'package:nepal_excaliber/screens/profile/address-form.dart';
import 'package:nepal_excaliber/utils/colors.dart';
import 'package:nepal_excaliber/utils/imagePaths.dart';
import 'package:nepal_excaliber/widgets/empty_widget.dart';
import 'package:nepal_excaliber/widgets/shirmmer-layout.dart';

import '../../widgets/address-item-widget.dart';

class SavedAddressScreen extends StatelessWidget {
  static const routeName = "/saved-address";
  final c = Get.find<SavedAddressController>();
  SavedAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Saved Address"),
          actions: [
            IconButton(
              onPressed: c.gotoAddressForm,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Obx(
          () => (c.loadingData.value)
              ? ShimmerWidgets.buildProductTileShimmer()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: (c.address.isEmpty)
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Obx(
                        () => (c.address.isEmpty)
                            ? const EmptyScreen(
                                image: ImagePath.NO_ADDRESS,
                                title: "No Address Found",
                                message: "Please add Address")
                            : ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: c.address.length,
                                itemBuilder: (context, index) {
                                  return AddressItemWidget(
                                    theme: theme,
                                    address: c.address[index],
                                    onEdit: () {
                                      Get.toNamed(AddressFormScreen.routeName,
                                          arguments: [true, c.address[index]]);
                                    },
                                    onDelete: () {
                                      c.deleteAddress(index);
                                    },
                                  );
                                },
                              ),
                      ),
                      GestureDetector(
                        onTap: c.gotoAddressForm,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            top: 12,
                            right: 12,
                            left: 12,
                          ),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.tertiaryColor),
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Add Address",
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(color: AppColors.tertiaryColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ));
  }
}
