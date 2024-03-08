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
import 'package:sales_management/utils/utils.dart';

typedef ReturnCallbac<R> = R Function();

class ProductSelectorItem extends StatefulWidget {
  final BeerSubmitData productData;
  final VoidCallbackArg<ProductInPackageResponse> updateNumberUnit;
  final VoidCallbackArg<List<ProductInPackageResponse>>? updateListNumberUnit;
  final VoidCallbackArg<BeerSubmitData>? onChanged;
  final Map<String, ProductInPackageResponse>? mapProductInPackage;
  final bool isProductSelector;
  final ReturnCallbackAsync<bool>? switchToAvariable;
  const ProductSelectorItem({
    super.key,
    required this.productData,
    required this.updateNumberUnit,
    required this.onChanged,
    required this.mapProductInPackage,
    this.isProductSelector = true,
    this.switchToAvariable,
    this.updateListNumberUnit,
  });

  @override
  State<ProductSelectorItem> createState() => _ProductSelectorItemState();
}

class _ProductSelectorItemState extends State<ProductSelectorItem> {
  late final String? imgUrl;
  late final String name;
  late final String rangePrice;
  bool processing = false;
  late Map<String, ProductInPackageResponse>? mapProductInPackage =
      widget.mapProductInPackage;
  ProductInPackageResponse? productInPackage;
  int unitNo = 0;
  late bool isAvariable;
  bool isNullUnit = false;
  late final bool isHaveMultiCategory = widget.productData.isHaveMultiCategory;
  late final bool isProductSelector = widget.isProductSelector;

  Key uiKey = UniqueKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!isProductSelector) {
      isNullUnit = widget.productData.firstOrNull == null;
    }
    name = isProductSelector
        ? widget.productData.name
        : widget.productData.firstOrNull?.name ?? 'Null';
    isAvariable = isProductSelector
        ? widget.productData.isAvariable
        : widget.productData.firstOrNull?.isAvariable ?? false;
    imgUrl = isProductSelector
        ? widget.productData.getFristLargeImg
        : widget.productData.getUnitFristLargeImg;

    productInPackage = mapProductInPackage?.entries.firstOrNull?.value;
    rangePrice = widget.productData.getRangePrice;
    updatePriceAndNoUnit();
  }

  void updatePriceAndNoUnit() {
    unitNo = 0;
    mapProductInPackage?.values.forEach((element) {
      unitNo += element.numberUnit;
    });
  }

  int setNumber() {
    if (productInPackage == null) {
      unitNo = 0;
      return unitNo;
    }
    widget.updateNumberUnit(productInPackage!);
    unitNo = productInPackage!.numberUnit;
    return unitNo;
  }

  int removeIfEmpty() {
    if (productInPackage!.numberUnit <= 0) {
      productInPackage!.numberUnit = 1; //set to 1 so can run remove func
      removeItemToPackage();
    }
    return unitNo;
  }

  int removeItemToPackage() {
    if (productInPackage == null || productInPackage!.numberUnit < 1) {
      return 0;
    }
    productInPackage!.numberUnit--;
    return setNumber();
  }

  int addItemToPackage() {
    productInPackage ??= ProductInPackageResponse.fromProductData(
        beerSubmitData: widget.productData);
    productInPackage!.numberUnit++;
    return setNumber();
  }

  void setDirectUnitNum(String numTxt) {
    if (productInPackage == null) {
      return;
    }
    productInPackage!.numberUnit = tryParseNumber(numTxt);
    setNumber();
  }

  @override
  Widget build(BuildContext context) {
    _switchToAvariable() async {
      if (isNullUnit || !isProductSelector) {
        return false;
      }
      await showDefaultDialog(
          context, 'Xác nhận thay đổi!', 'Sản phẩm đã có hàng lại?',
          onOk: () {
        widget.productData.changeStatus(true);
        LoadingOverlayAlt.of(context).show();
        createProduct(widget.productData).then((value) {
          LoadingOverlayAlt.of(context).hide();
          isAvariable = widget.productData.isAvariable;
          widget.onChanged?.call(widget.productData);
        }).onError((error, stackTrace) {
          LoadingOverlayAlt.of(context).hide();
          widget.productData.changeStatus(false);
          showAlert(
              context, 'Lỗi hệ thống không thể cập nhật sản phẩm!!!');
        });
      }, onCancel: () {});
      return isAvariable;
    }

    showSelectUnitModal() => showDefaultModal(
          context: context,
          content: ModalSelectProductUnitCategory(
            product: widget.productData,
            mapProductInPackage: mapProductInPackage,
            swithAvariable: (b) async {
              b.changeUnitStatus(b.firstOrNull, true);
              return _switchToAvariable();
            },
            onDone: (Map<String, ProductInPackageResponse> maps) {
              mapProductInPackage = maps;
              updatePriceAndNoUnit();
              uiKey = UniqueKey();
              widget.updateListNumberUnit?.call(maps.values.toList());
              setState(() {});
            },
          ),
        );

    return ProductSelectorItemUI(
      key: uiKey,
      name: name,
      imgUrl: imgUrl,
      rangePrice: rangePrice,
      unitNo: unitNo,
      addItemToPackage: addItemToPackage,
      isHaveMultiCategory: isHaveMultiCategory,
      removeItemToPackage: removeItemToPackage,
      switchToAvariable: widget.switchToAvariable ?? _switchToAvariable,
      onTxtChanged: (value) {
        setDirectUnitNum(value);
      },
      onTapOutside: removeIfEmpty,
      isAvariable: isAvariable,
      isNullUnit: isNullUnit,
      showSelectUnitModal: showSelectUnitModal,
    );
  }
}

class ProductSelectorItemUI extends StatefulWidget {
  final int unitNo;
  final String? imgUrl;
  final String name;
  final String rangePrice;
  final ReturnCallbac<int> addItemToPackage;
  final ReturnCallbac<int> removeItemToPackage;
  final ReturnCallbackAsync<bool> switchToAvariable;
  final VoidCallback showSelectUnitModal;
  final VoidCallbackArg<String> onTxtChanged;
  final ReturnCallbac<int> onTapOutside;
  final bool isHaveMultiCategory;
  final bool isAvariable;
  final bool isNullUnit;

  const ProductSelectorItemUI({
    super.key,
    required this.unitNo,
    required this.imgUrl,
    required this.name,
    required this.rangePrice,
    required this.addItemToPackage,
    required this.isHaveMultiCategory,
    required this.removeItemToPackage,
    required this.switchToAvariable,
    required this.onTxtChanged,
    required this.onTapOutside,
    required this.isAvariable,
    required this.isNullUnit,
    required this.showSelectUnitModal,
  });

  @override
  State<ProductSelectorItemUI> createState() => _ProductSelectorItemUIState();
}

class _ProductSelectorItemUIState extends State<ProductSelectorItemUI> {
  final TextEditingController txtController = TextEditingController();
  final FocusNode txtFocus = FocusNode();
  late int unitNo = widget.unitNo;
  late bool isAvariable = widget.isAvariable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtController.text = unitNo.toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtController.dispose();
    txtFocus.dispose();
  }

  late final onAddItem = widget.isHaveMultiCategory
      ? widget.showSelectUnitModal
      : () {
          unitNo = widget.addItemToPackage();
          txtController.text = unitNo.toString();
          setState(() {});
        };

  late final onRemoveItem = widget.isHaveMultiCategory
      ? widget.showSelectUnitModal
      : () {
          unitNo = widget.removeItemToPackage();
          txtController.text = unitNo.toString();
          setState(() {});
        };

  void removeIfEmpty() {
    unitNo = widget.onTapOutside();
    txtController.text = unitNo.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onAddItem,
          child: Container(
            decoration: BoxDecoration(
              color: White,
              boxShadow: unitNo > 0 ? [highShadow] : null,
              borderRadius: defaultBorderRadius,
              border: unitNo > 0 ? tableHighBorder : defaultBorder,
              image: DecorationImage(
                image: (widget.imgUrl == null
                    ? const AssetImage(
                        'assets/images/shop_logo.png',
                      )
                    : NetworkImage(widget.imgUrl!)) as ImageProvider,
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
                              onTap: onRemoveItem,
                              child: LoadSvg(assetPath: 'svg/minus.svg'),
                            ),
                            SizedBox(
                              width: 18,
                              child: TextFormField(
                                controller: txtController,
                                focusNode: txtFocus,
                                readOnly: widget.isHaveMultiCategory,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onTapOutside: (event) {
                                  txtFocus.unfocus();
                                  removeIfEmpty();
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLines: 1,
                                style: headStyleLarge,
                                onChanged: widget.onTxtChanged,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: onAddItem,
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
                            widget.name,
                            style: subInfoStyLarge400,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.rangePrice,
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
        if (!isAvariable || widget.isNullUnit)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                widget.switchToAvariable().then((value) {
                  isAvariable = value;
                  setState(() {});
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: White70,
                  borderRadius: defaultBorderRadius,
                ),
                child: const Center(
                  child: Text('Hết hàng'),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
