import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/common/products-screen-controller.dart';
import 'package:nepal_excaliber/utils/colors.dart';
import 'package:nepal_excaliber/widgets/custom-snackbar.dart';
import 'package:nepal_excaliber/widgets/custom-text-field.dart';
import 'package:nepal_excaliber/widgets/product-grid-view.dart';
import 'package:nepal_excaliber/widgets/shirmmer-layout.dart';

import '../../models/category.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = "/product-screen";
  ProductScreen({Key? key}) : super(key: key);

  final c = Get.find<ProductScreenController>();

  @override
  Widget build(BuildContext context) {
    final Category category = Get.arguments['category'];
    final theme = Theme.of(context);
    c.loadCategoryProducts(category);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.6,
          iconTheme: const IconThemeData.fallback(),
          backgroundColor: theme.colorScheme.secondary,
          title: Text(
            category.title!,
            style: theme.textTheme.titleLarge!.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 6,
                      child: CustomTextField(
                        autoFocus: false,
                        prefixIcon: const Icon(Icons.search_sharp),
                        textInputAction: TextInputAction.search,
                        hint: "Search",
                        onSubmit: (val) {
                          CustomSnackBar.success();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    // Flexible(
                    //   flex: 1,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: theme.colorScheme.secondary,
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: IconButton(
                    //       onPressed: () {},
                    //       icon: const Icon(
                    //         Icons.sort_sharp,
                    //         size: 32,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Obx((() => (c.loadingProducts.value)
                    ? ShimmerWidgets.buildProductCardShimmer()
                    : ProductGridView(products: c.products)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
