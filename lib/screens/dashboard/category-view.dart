import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_excaliber/controller/dashboard/category-controller.dart';
import 'package:nepal_excaliber/widgets/category-item.dart';

class CategoryContentView extends StatelessWidget {
  CategoryContentView({Key? key}) : super(key: key);

  final c = Get.find<CategoryViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: c.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return CategoryItem(
                category: c.categories[index],
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}
