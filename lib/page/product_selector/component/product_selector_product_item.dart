import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/product_info/api/product_info_api.dart';
import 'package:sales_management/page/product_selector/component/modal_select_product_unit.dart';
import 'package:sales_management/page/product_selector/component/product_selector_product_item_ui.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class ProductSelectorItem extends StatefulWidget {
  final BeerSubmitData productData;
  final VoidCallbackArg<ProductInPackageResponse> updateNumberUnit;
  final VoidCallbackArg<List<ProductInPackageResponse>>? updateListNumberUnit;
  final VoidCallbackArg<BeerSubmitData>? onChanged;
  final Map<String, ProductInPackageResponse>? mapProductInPackage;
  const ProductSelectorItem({
    super.key,
    required this.productData,
    required this.updateNumberUnit,
    required this.onChanged,
    required this.mapProductInPackage,
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
  int inventoryNum = 0;
  late bool isAvariable;
  late final bool isHaveMultiCategory = widget.productData.isHaveMultiCategory;

  Key uiKey = UniqueKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    name = widget.productData.name;
    isAvariable = widget.productData.isAvariable;
    imgUrl = widget.productData.getFristLargeImg;

    productInPackage = mapProductInPackage?.entries.firstOrNull?.value;
    rangePrice = widget.productData.getRangePrice;
    inventoryNum = widget.productData.getTotalInventory;
    updatePriceAndNoUnit();

    //if it alredy save in server mean inventory alredy sub
    if (productInPackage?.isTempPackageItem == false) {
      inventoryNum += unitNo;
    }
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
    setState(() {});
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
    _switchToAvariable({bool isRunOnchange = true}) async {
      await showDefaultDialog(
          context, 'Xác nhận thay đổi!', 'Sản phẩm đã có hàng lại?',
          onOk: () {
        widget.productData.changeStatus(true);
        LoadingOverlayAlt.of(context).show();
        createProduct(widget.productData).then((value) {
          LoadingOverlayAlt.of(context).hide();
          isAvariable = widget.productData.isAvariable;
          if (isRunOnchange) {
            widget.onChanged?.call(widget.productData);
          }
          setState(() {});
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
              return _switchToAvariable(isRunOnchange: false);
            },
            onDone: (Map<String, ProductInPackageResponse> maps) {
              mapProductInPackage = maps;
              updatePriceAndNoUnit();
              uiKey = UniqueKey();
              widget.updateListNumberUnit?.call(maps.values.toList());
              setState(() {});
            },
            onRefreshData: () => widget.onChanged?.call(widget.productData),
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
      switchToAvariable: _switchToAvariable,
      onTxtChanged: (value) {
        setDirectUnitNum(value);
      },
      onTapOutside: removeIfEmpty,
      isAvariable: isAvariable,
      isNullUnit: false,
      showSelectUnitModal: showSelectUnitModal,
      inventoryNum: inventoryNum - unitNo,
    );
  }
}
