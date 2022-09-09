import 'package:flutter/material.dart';
import 'package:nepal_excaliber/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidgets {
  static Widget buildProductTileShimmer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.secondaryColor),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 100,
                    child: Image.network(
                      "https://picsum.photos/200/200",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      (100 + 12 + 12 + 8 + 8 + 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "dasdhasd d asdkasdas das d asd as d as",
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "dasdasdasdasa sdad",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.hintTextColor),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Rs. 4654654",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget buildProductCardShimmer() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.secondaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Demo Product",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 4,
                  ),
                  child: Text(
                    "Rs. 23123",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.hintTextColor),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    ;
  }
}
