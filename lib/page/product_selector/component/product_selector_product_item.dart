import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/product_info/api/product_info_api.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class ProductSelectorItem extends StatefulWidget {
  final BeerSubmitData productData;
  final ProductInPackageResponse? productInPackageResponse;
  final VoidCallbackArg<ProductInPackageResponse> updateNumberUnit;
  final VoidCallbackArg<BeerSubmitData> onChanged;
  const ProductSelectorItem({
    super.key,
    required this.productData,
    required this.productInPackageResponse,
    required this.updateNumberUnit,
    required this.onChanged,
  });

  @override
  State<ProductSelectorItem> createState() => _ProductSelectorItemState();
}

class _ProductSelectorItemState extends State<ProductSelectorItem> {
  late final String? imgUrl;
  late final String name;
  late final double price;
  bool processing = false;
  late BeerUnit? unit;
  late ProductInPackageResponse? productInPackage;
  late int unitNo;
  final TextEditingController txtController = TextEditingController();
  late bool isAvariable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unit = widget.productData.listUnit?.firstOrNull;
    imgUrl = widget.productData.getFristLargeImg;
    name = widget.productData.get_show_name;
    price = widget.productData.getRealPrice;
    productInPackage = widget.productInPackageResponse;
    unitNo = productInPackage?.numberUnit ?? 0;
    txtController.text = unitNo.toString();
    isAvariable = widget.productData.isAvariable;
  }

  void removeItemToPackage() {
    if (productInPackage == null || productInPackage!.numberUnit < 1) {
      return;
    }
    productInPackage!.numberUnit--;
    widget.updateNumberUnit(productInPackage!);
    unitNo = productInPackage!.numberUnit;
    txtController.text = unitNo.toString();
    setState(() {});
  }

  void addItemToPackage() {
    productInPackage ??=
        ProductInPackageResponse(beerSubmitData: widget.productData);
    productInPackage!.numberUnit++;
    widget.updateNumberUnit(productInPackage!);
    unitNo = productInPackage!.numberUnit;
    txtController.text = unitNo.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: addItemToPackage,
          child: Container(
            decoration: BoxDecoration(
              color: White,
              boxShadow: unitNo > 0 ? [highShadow] : null,
              borderRadius: defaultBorderRadius,
              border: unitNo > 0 ? tableHighBorder : defaultBorder,
              image: DecorationImage(
                image: (imgUrl == null
                    ? const AssetImage(
                        'assets/images/shop_logo.png',
                      )
                    : NetworkImage(imgUrl!)) as ImageProvider,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                unitNo > 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        margin:
                            const EdgeInsets.only(top: 12, left: 6, right: 6),
                        decoration: BoxDecoration(
                            color: White,
                            borderRadius: defaultSquareBorderRadius,
                            border: defaultBorder),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: LoadSvg(assetPath: 'svg/minus.svg'),
                              onTap: () {
                                removeItemToPackage();
                              },
                            ),
                            SizedBox(
                              width: 18,
                              child: TextFormField(
                                controller: txtController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLines: 1,
                                style: headStyleLarge,
                                onChanged: (value) {
                                  if (productInPackage == null) {
                                    return;
                                  }
                                  productInPackage!.numberUnit =
                                      int.tryParse(value) ?? 0;
                                  if (productInPackage!.numberUnit <= 0) {
                                    productInPackage!.numberUnit =
                                        1; //set to 1 so can run remove func
                                    removeItemToPackage();
                                  }
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                addItemToPackage();
                              },
                              child: LoadSvg(
                                assetPath: 'svg/plus.svg',
                                color: MainHighColor,
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.0,
                      sigmaY: 4.0,
                    ),
                    child: Container(
                      color: Color.fromRGBO(214, 214, 214, 0.40),
                      child: Column(
                        children: [
                          Text(
                            name,
                            style: subInfoStyLarge400,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                MoneyFormater.format(price),
                                style: subInfoStyLarge600,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isAvariable)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                showDefaultDialog(context, 'Xác nhận thay đổi!',
                    'Sản phẩm đã có hàng lại?', onOk: () {
                  widget.productData.changeStatus(true);
                  LoadingOverlayAlt.of(context).show();
                  createProduct(widget.productData).then((value) {
                    LoadingOverlayAlt.of(context).hide();
                    isAvariable = widget.productData.isAvariable;
                    widget.onChanged(widget.productData);
                    setState(() {});
                  }).onError((error, stackTrace) {
                    LoadingOverlayAlt.of(context).hide();
                    widget.productData.changeStatus(false);
                    showAlert(context,
                        'Lỗi hệ thống không thể cập nhật sản phẩm!!!');
                  });
                }, onCancel: () {});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: White70,
                  borderRadius: defaultBorderRadius,
                ),
                child: Center(
                  child: Text('Hết hàng'),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
