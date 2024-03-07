import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/product_info/api/product_info_api.dart';
import 'package:sales_management/page/product_selector/component/modal_select_product_unit.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class ProductSelectorItem extends StatefulWidget {
  final BeerSubmitData productData;
  final VoidCallbackArg<ProductInPackageResponse> updateNumberUnit;
  final VoidCallbackArg<BeerSubmitData> onChanged;
  final Map<String, ProductInPackageResponse>? productInPackage;
  final bool isProductSelector;
  const ProductSelectorItem({
    super.key,
    required this.productData,
    required this.updateNumberUnit,
    required this.onChanged,
    required this.productInPackage,
    this.isProductSelector = true,
  });

  @override
  State<ProductSelectorItem> createState() => _ProductSelectorItemState();
}

class _ProductSelectorItemState extends State<ProductSelectorItem> {
  late final String? imgUrl;
  late final String name;
  late final String rangePrice;
  bool processing = false;
  late List<BeerUnit>? listUnit;
  late Map<String, ProductInPackageResponse>? mapProductInPackage;
  ProductInPackageResponse? productInPackage;
  int unitNo = 0;
  final TextEditingController txtController = TextEditingController();
  final FocusNode txtFocus = FocusNode();
  late bool isAvariable;
  late final bool isHaveMultiCategory = widget.productData.isHaveMultiCategory;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtController.dispose();
    txtFocus.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listUnit = widget.productData.listUnit;
    imgUrl = widget.productData.getFristLargeImg;
    name = widget.productData.name;
    rangePrice = widget.productData.getRangePrice;
    mapProductInPackage = widget.productInPackage;
    if (widget.isProductSelector && !widget.productData.isHaveMultiCategory) {
      productInPackage = mapProductInPackage?.entries.firstOrNull?.value;
    }
    mapProductInPackage?.values.forEach((element) {
      unitNo += element.numberUnit;
    });
    txtController.text = unitNo.toString();
    isAvariable = widget.productData.isAvariable;

    print(unitNo);
  }

  void setNumber() {
    widget.updateNumberUnit(productInPackage!);
    unitNo = productInPackage!.numberUnit;
    txtController.text = unitNo.toString();
  }

  void removeIfEmpty() {
    if (productInPackage!.numberUnit <= 0) {
      productInPackage!.numberUnit = 1; //set to 1 so can run remove func
      removeItemToPackage();
    }
  }

  void removeItemToPackage() {
    if (productInPackage == null || productInPackage!.numberUnit < 1) {
      return;
    }
    productInPackage!.numberUnit--;
    setNumber();
    setState(() {});
  }

  void addItemToPackage() {
    productInPackage ??= ProductInPackageResponse.fromProductData(
        beerSubmitData: widget.productData);
    productInPackage!.numberUnit++;
    setNumber();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    showSelectUnitModal() => showDefaultModal(
          context: context,
          content: ModalSelectProductUnitCategory(
            onDone: (category) {},
            product: widget.productData,
          ),
        );
    return Stack(
      children: [
        GestureDetector(
          onTap: isHaveMultiCategory ? showSelectUnitModal : addItemToPackage,
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
                unitNo > 0 || txtFocus.hasFocus
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
                              onTap: isHaveMultiCategory
                                  ? showSelectUnitModal
                                  : removeItemToPackage,
                            ),
                            SizedBox(
                              width: 18,
                              child: TextFormField(
                                controller: txtController,
                                focusNode: txtFocus,
                                readOnly: isHaveMultiCategory,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onTapOutside: (event) {
                                  txtFocus.unfocus();
                                  removeIfEmpty();
                                  setState(() {});
                                },
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
                                  // if (productInPackage!.numberUnit <= 0) {
                                  //   productInPackage!.numberUnit =
                                  //       1; //set to 1 so can run remove func
                                  //   removeItemToPackage();
                                  // }
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: isHaveMultiCategory
                                  ? showSelectUnitModal
                                  : addItemToPackage,
                              child: LoadSvg(
                                assetPath: 'svg/plus.svg',
                                color: MainHighColor,
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
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
                                rangePrice,
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
