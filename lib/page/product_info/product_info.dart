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
import 'package:sales_management/utils/snack_bar.dart';
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
    return LoadingOverlayAlt(
      child: ProductInfoBody(product: product, onAdded: onAdded),
    );
  }
}

class ProductInfoBody extends StatelessWidget {
  const ProductInfoBody({
    super.key,
    required this.product,
    required this.onAdded,
  });

  final BeerSubmitData product;
  final VoidCallbackArg<BeerSubmitData>? onAdded;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
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
                StoreManagement(
                  product: product,
                ),
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
            }).onError((error, stackTrace) {
              LoadingOverlayAlt.of(context).hide();
              showAlert(
                  context, 'Lỗi hệ thống không thể tạo sản phẩm!!!');
            });
          },
          cancel: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
