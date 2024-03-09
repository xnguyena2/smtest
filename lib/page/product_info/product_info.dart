import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/product_info/api/product_info_api.dart';
import 'package:sales_management/page/product_info/component/product_data_provider.dart';
import 'package:sales_management/page/product_info/component/product_info_bar.dart';
import 'package:sales_management/page/product_info/component/product_info_create_category.dart';
import 'package:sales_management/page/product_info/component/product_info_create_combo.dart';
import 'package:sales_management/page/product_info/component/product_info_img_management.dart';
import 'package:sales_management/page/product_info/component/product_info_main_info.dart';
import 'package:sales_management/page/product_info/component/product_info_store_management.dart';
import 'package:sales_management/page/product_info/component/product_more_setting.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/typedef.dart';

class ProductInfo extends StatelessWidget {
  final BeerSubmitData product;
  final VoidCallbackArg<BeerSubmitData>? onAdded;
  final VoidCallbackArg<BeerSubmitData>? onDeleted;
  const ProductInfo({
    super.key,
    required this.product,
    this.onAdded,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: ProductInfoBody(
        product: product,
        onAdded: onAdded,
        onDeleted: onDeleted,
      ),
    );
  }
}

class ProductInfoBody extends StatelessWidget {
  const ProductInfoBody({
    super.key,
    required this.product,
    required this.onAdded,
    this.onDeleted,
  });

  final BeerSubmitData product;
  final VoidCallbackArg<BeerSubmitData>? onAdded;
  final VoidCallbackArg<BeerSubmitData>? onDeleted;

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    height: 14,
                  ),
                  StoreManagement(
                    product: product,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  ProductCreateCategory(
                    product: product,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  // CreateCombo(),
                  // MoreSetting(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomBar(
            okBtnTxt: 'Cập nhật',
            enableDelete: true,
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
              showDefaultDialog(context, 'Xác nhận xóa!',
                  'Bạn có chắc muốn xóa sản phẩm?', onOk: () {
                LoadingOverlayAlt.of(context).show();
                deleteProduct(product).then((value) {
                  LoadingOverlayAlt.of(context).hide();
                  onDeleted?.call(product);
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  LoadingOverlayAlt.of(context).hide();
                  showAlert(
                      context, 'Lỗi hệ thống không thể xóa sản phẩm!!!');
                });
              }, onCancel: () {});
            },
          ),
        ),
      ),
    );
  }
}
