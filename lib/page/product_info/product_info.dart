import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/product_info/api/product_info_api.dart';
import 'package:sales_management/page/product_info/component/product_info_bar.dart';
import 'package:sales_management/page/product_info/component/product_info_create_combo.dart';
import 'package:sales_management/page/product_info/component/product_info_img_management.dart';
import 'package:sales_management/page/product_info/component/product_info_main_info.dart';
import 'package:sales_management/page/product_info/component/product_info_store_management.dart';
import 'package:sales_management/page/product_info/component/product_more_setting.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class ProductInfo extends StatelessWidget {
  final BeerSubmitData product;
  final VoidCallbackArg<BeerSubmitData>? onAdded;
  const ProductInfo({
    super.key,
    required this.product,
    this.onAdded,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProductInfoBar(),
        body: Container(
          color: BackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImgManagement(
                  product: product,
                ),
                MainProductInfo(
                  product: product,
                ),
                SizedBox(
                  height: 14,
                ),
                StoreManagement(),
                SizedBox(
                  height: 14,
                ),
                CreateCombo(),
                MoreSetting(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(
          okBtnTxt: 'Cập nhật',
          done: () {
            LoadingOverlayAlt.of(context).show();
            createProduct(product).then((value) {
              value.copyImg(product);
              onAdded?.call(value);
              LoadingOverlayAlt.of(context).hide();
              Navigator.pop(context);
            });
          },
          cancel: () {},
        ),
      ),
    );
  }
}
