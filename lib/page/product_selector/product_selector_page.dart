import 'package:flutter/material.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bar.dart';

class ProductSelectorPage extends StatelessWidget {
  const ProductSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      appBar: ProductSelectorBar(),
      body: Placeholder(),
    ));
  }
}
