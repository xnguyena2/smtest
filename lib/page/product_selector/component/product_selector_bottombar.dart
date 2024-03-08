import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/bottom_bar_done_select_product.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';

class ProductSelectorBottomBar extends StatelessWidget {
  final VoidCallback done;
  final VoidCallback cancel;
  const ProductSelectorBottomBar({
    super.key,
    required this.done,
    required this.cancel,
  });

  @override
  Widget build(BuildContext context) {
    PackageDataResponse? package = context.watch<ProductProvider>().getPackage;
    return BottomBarDoneSelectProduct(
      numItem: package?.numItem ?? 0,
      done: done,
      totalPriceFormat: '${package?.totalPriceFormat ?? 0}',
    );
  }
}
