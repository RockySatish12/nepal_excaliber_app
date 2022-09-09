import 'package:flutter/material.dart';
import 'package:nepal_excaliber/widgets/product-card-item.dart';

import '../models/product.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 210,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        return ProductCardItem(product: product);
      },
    );
  }
}
