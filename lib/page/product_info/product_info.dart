import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/page/product_info/component/product_info_bar.dart';
import 'package:sales_management/page/product_info/component/product_info_create_combo.dart';
import 'package:sales_management/page/product_info/component/product_info_img_management.dart';
import 'package:sales_management/page/product_info/component/product_info_main_info.dart';
import 'package:sales_management/page/product_info/component/product_info_store_management.dart';
import 'package:sales_management/page/product_info/component/product_more_setting.dart';
import 'package:sales_management/utils/constants.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

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
                ImgManagement(),
                MainProductInfo(),
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
          done: () {},
          cancel: () {},
        ),
      ),
    );
  }
}
