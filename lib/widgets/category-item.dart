import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/screens/common/products-screen.dart';

import '../models/category.dart';
import '../utils/colors.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final int index;

  const CategoryItem({Key? key, required this.category, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(ProductScreen.routeName, arguments: {"category": category});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.secondaryColor),
        child: Row(
          children: getChildrens(context),
        ),
      ),
    );
  }

  List<Widget> getChildrens(BuildContext context) {
    var childrens = [
      const SizedBox(
        width: 12,
      ),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          category.title!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 200,
          child: Text(
            category.description!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.hintTextColor),
          ),
        ),
      ]),
      const Spacer(),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            category.imageUrl!,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(
        width: 12,
      )
    ];
    if (index % 2 == 0) return childrens.reversed.toList();
    return childrens;
  }
}
