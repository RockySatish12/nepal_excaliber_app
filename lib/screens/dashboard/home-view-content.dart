
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/home-view-controller.dart';
import 'package:nepal_excaliber/utils/colors.dart';
import 'package:nepal_excaliber/widgets/shirmmer-layout.dart';

import '../../widgets/product-grid-view.dart';
import '../../widgets/product-item-tile.dart';

class HomeViewContent extends StatelessWidget {
  HomeViewContent({Key? key}) : super(key: key);

  final c = Get.find<HomeViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              // CarouselSlider.builder(
              //   itemCount: c.bannerImages.length,
              //   itemBuilder: (BuildContext context, int index, int pageIndex) {
              //     return ClipRRect(
              //       borderRadius: BorderRadius.circular(12),
              //       child: Image.network(
              //         c.bannerImages[index],
              //         fit: BoxFit.scaleDown,
              //       ),
              //     );
              //   },
              //   options: CarouselOptions(
              //     height: 200,
              //     initialPage: 0,
              //     reverse: true,
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     scrollDirection: Axis.horizontal,
              //     enlargeCenterPage: true,
              //     aspectRatio: 16 / 9,
              //   ),
              // ),
              const SizedBox(
                height: 24,
              ),
              ...buildLatestProductSection(context),
              const SizedBox(
                height: 24,
              ),
              ...buildStyleSection(context)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildLatestProductSection(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "Latest Products",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      Obx(
        () => c.latestProductLoading.value
            ? ShimmerWidgets.buildProductTileShimmer()
            : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: c.latestProduct.length,
                itemBuilder: (BuildContext context, index) {
                  return ProductItemTile(
                    product: c.latestProduct[index],
                  );
                },
              ),
      )
    ];
  }

  List<Widget> buildStyleSection(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "Find your Style",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      SizedBox(
        height: 45,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            buildStyleHeader(context, title: "Featured Products", index: 0),
            // buildStyleHeader(context, title: "Top Picks", index: 1),
            // buildStyleHeader(context, title: "Featured Products", index: 2),
            // buildStyleHeader(context, title: "Clothing", index: 3)
          ],
        ),
      ),
      Obx(
        () => c.latestProductLoading.value
            ? ShimmerWidgets.buildProductTileShimmer()
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ProductGridView(
                  products: c.featuredProduct,
                ),
              ),
      )
    ];
  }

  Widget buildStyleHeader(BuildContext context,
      {required String title, required int index}) {
    return Obx(
      () => InkWell(
        onTap: () {
          c.styleSectionIndex.value = index;
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 12),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
              color: (c.styleSectionIndex.value == index)
                  ? AppColors.tertiaryColor
                  : AppColors.borderColor,
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: (c.styleSectionIndex.value == index)
                    ? AppColors.secondaryColor
                    : AppColors.textColor),
          ),
        ),
      ),
    );
  }
}
