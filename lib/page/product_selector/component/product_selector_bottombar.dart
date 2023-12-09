import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

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
    return Container(
      padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: White,
        boxShadow: [wholeShadow],
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: defaultBorderRadius,
          color: TableHighColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    LoadSvg(assetPath: 'svg/cart.svg'),
                    Positioned(
                      right: -6,
                      top: -6,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Red,
                        child: Text(
                          '${package?.numItem ?? 0}',
                          style: headStyleMediumWhite500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 28,
                ),
                Text(
                  '${package?.totalPriceFormat ?? 0}',
                  style: customerNameBigWhite600,
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: done,
                  child: Text(
                    'Tiếp tục',
                    style: headStyleLargeWhite,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
