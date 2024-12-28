import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/common/delivery_controller.dart';
import 'package:nepal_excaliber/utils/colors.dart';
import 'package:nepal_excaliber/utils/imagePaths.dart';
import 'package:nepal_excaliber/widgets/empty_widget.dart';

class DeliveryScreen extends StatelessWidget {
  static const String routeName = "/delivery-screen";
  final c = Get.find<DeliveryController>();
  DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.primaryColor,
            )),
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          "Delivery Address",
          style: theme.textTheme.titleLarge!,
        ),
      ),
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          width: double.infinity,
          height: (c.address.isEmpty) ? 0 : 56,
          color: AppColors.secondaryColor,
          duration: const Duration(microseconds: 300),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "Rs ${(c.cartController.totalCost.value - c.cartController.totalDiscount.value).toStringAsFixed(2)}",
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.tertiaryColor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Total",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              Expanded(child: Container()),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      minimumSize: const Size.fromHeight(30)),
                  onPressed: () {
                    c.makePayment();
                  },
                  child: Text(
                    "Pay with Esewa",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: Column(
          children: [
            Obx(
              () => (c.loadingData.value)
                  ? const LinearProgressIndicator()
                  : (c.address.isEmpty)
                      ? const EmptyScreen(
                          image: ImagePath.NO_ADDRESS,
                          title: "No Address Found",
                          message: "Please Add address from profile screen")
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: c.address.length,
                          itemBuilder: ((context, index) {
                            var address = c.address[index];
                            return Column(
                              children: [
                                RadioListTile(
                                  activeColor: AppColors.tertiaryColor,
                                  title: Text(
                                      "${address.label} (${address.contact})"),
                                  subtitle: Text(address.toString()),
                                  value: index,
                                  groupValue: c.selectedAddress.value,
                                  onChanged: (val) {},
                                ),
                                const Divider(
                                  color: AppColors.borderColor,
                                  thickness: 1,
                                )
                              ],
                            );
                          }),
                        ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.secondaryColor),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Sub-total",
                        style: theme.textTheme.bodyLarge,
                      )),
                      Obx(() => Text(
                            "Rs ${c.cartController.totalCost.value.toStringAsFixed(2)}",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: AppColors.hintTextColor),
                          ))
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Discount",
                        style: theme.textTheme.bodyLarge,
                      )),
                      Obx(() => Text(
                            "Rs ${c.cartController.totalDiscount.value.toStringAsFixed(2)}",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: AppColors.errorColor),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColors.borderColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Grand-total",
                        style: theme.textTheme.bodyLarge,
                      )),
                      Obx(() => Text(
                            "Rs ${(c.cartController.totalCost.value - c.cartController.totalDiscount.value).toStringAsFixed(2)}",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: AppColors.tertiaryColor),
                          )),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
