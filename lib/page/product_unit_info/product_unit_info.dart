import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/product_info/component/product_data_provider.dart';
import 'package:sales_management/page/product_info/component/product_info_img_management.dart';
import 'package:sales_management/page/product_info/component/product_info_main_info.dart';
import 'package:sales_management/page/product_info/component/product_info_store_management.dart';
import 'package:sales_management/page/product_unit_info/component/product_unit_info_bar.dart';
import 'package:sales_management/page/product_unit_info/component/product_unit_info_hide.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class ProductUnitInfo extends StatelessWidget {
  final BeerSubmitData product;
  final VoidCallbackArg<BeerSubmitData>? onAdded;
  const ProductUnitInfo({
    super.key,
    required this.product,
    this.onAdded,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: ProductUnitInfoBody(
        product: product,
        onAdded: onAdded,
      ),
    );
  }
}

class ProductUnitInfoBody extends StatelessWidget {
  const ProductUnitInfoBody({
    super.key,
    required this.product,
    required this.onAdded,
  });

  final BeerSubmitData product;
  final VoidCallbackArg<BeerSubmitData>? onAdded;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductDataProvider(beerSubmitData: product),
        ),
      ],
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: const ProductUnitInfoBar(),
          body: Container(
            color: BackgroundColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImgManagement(
                    product: product,
                    isForProductUnit: true,
                  ),
                  MainProductInfo(
                    product: product,
                    isForProductUnit: true,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  StoreManagement(
                    product: product,
                    isForProductUnit: true,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  ProductUnitInfoHide(
                    product: product,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  // CreateCombo(),
                  // MoreSetting(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 60 + bottomPadding,
            padding:
                EdgeInsets.only(right: 15, left: 15, bottom: bottomPadding),
            decoration: const BoxDecoration(
              color: White,
              boxShadow: [wholeShadow],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ApproveBtn(
                    isActiveOk: true,
                    txt: 'Cập nhật',
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onPressed: () {
                      onAdded?.call(product);
                      Navigator.pop(context);
                    },
                    backgroundColor: HighColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
