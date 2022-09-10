import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nepal_excaliber/controller/profile/order-controler.dart';
import 'package:nepal_excaliber/utils/date_helper.dart';
import 'package:nepal_excaliber/utils/imagePaths.dart';
import 'package:nepal_excaliber/widgets/empty_widget.dart';
import 'package:nepal_excaliber/widgets/shirmmer-layout.dart';

import '../../utils/colors.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/orders";
  final c = Get.find<OrderScreenControler>();
  OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Obx(() => c.isLoading.value
          ? ShimmerWidgets.buildProductTileShimmer()
          : c.orders.isEmpty
              ? const EmptyScreen(
                  image: ImagePath.NO_PRODUCTS,
                  title: "No Order Found",
                  message: "Please make some orders")
              : ListView.builder(
                  itemCount: c.orders.length,
                  itemBuilder: (context, index) {
                    var order = c.orders[index];
                    return Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.secondaryColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  width: 120,
                                  child: CachedNetworkImage(
                                    imageUrl: (order.product?.imageUrl ?? ""),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width - 180,
                                    child: Text(
                                      order.product!.title!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Quantity: x${order.quantity}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.4),
                                              blurRadius: 0.2,
                                              blurStyle: BlurStyle.outer,
                                            )
                                          ],
                                          color: AppColors.hexToColor(
                                              "${order.color}"),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.4),
                                              blurRadius: 0.2,
                                              blurStyle: BlurStyle.outer,
                                            )
                                          ],
                                          color: AppColors.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${order.size}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: AppColors.textColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ordered:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color:
                                                    AppColors.hintTextColor)),
                                    Text(
                                        DateHelper.prettyDate(DateTime.parse(
                                            order.order!.orderDate!)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Delivery Status:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color:
                                                    AppColors.hintTextColor)),
                                    Text(order.order!.deliveryStatus!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                )),
    );
  }
}
