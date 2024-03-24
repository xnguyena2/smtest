import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/product_selector/component/product_selector_product_item_ui.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class ProductUnitSelectorItem extends StatefulWidget {
  final BeerSubmitData productData;
  final VoidCallbackArg<ProductInPackageResponse> updateNumberUnit;
  final VoidCallbackArg<List<ProductInPackageResponse>>? updateListNumberUnit;
  final VoidCallbackArg<BeerSubmitData>? onChanged;
  final Map<String, ProductInPackageResponse>? mapProductInPackage;
  final ReturnCallbackAsync<bool> switchToAvariable;
  const ProductUnitSelectorItem({
    super.key,
    required this.productData,
    required this.updateNumberUnit,
    required this.onChanged,
    required this.mapProductInPackage,
    required this.switchToAvariable,
    this.updateListNumberUnit,
  });

  @override
  State<ProductUnitSelectorItem> createState() =>
      _ProductUnitSelectorItemState();
}

class _ProductUnitSelectorItemState extends State<ProductUnitSelectorItem> {
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
  bool isNullUnit = false;
  late final bool isHaveMultiCategory = widget.productData.isHaveMultiCategory;
  late final bool isEnableWarehouse = widget.productData.isEnableWarehouse;

  Key uiKey = UniqueKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNullUnit = widget.productData.firstOrNull == null;
    name = widget.productData.firstOrNull?.name ?? 'Null';
    isAvariable = widget.productData.firstOrNull?.isAvariable ?? false;
    imgUrl = widget.productData.getUnitFristLargeImg;

    productInPackage = mapProductInPackage?.entries.firstOrNull?.value;
    rangePrice = widget.productData.getRangePrice;
    updateVentoryAndUnitNo();
  }

  void updateVentoryAndUnitNo() {
    inventoryNum = widget.productData.getTotalInventory;
    unitNo = 0;
    mapProductInPackage?.values.forEach((element) {
      unitNo += element.numberUnit;
    });
  }

  void updateInventory(int offset) {
    if (widget.productData.isEnableWarehouse) {
      inventoryNum = widget.productData.getInventory + offset;
      widget.productData.setInventory = inventoryNum;
    }
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
    updateInventory(1);
    return setNumber();
  }

  int addItemToPackage() {
    productInPackage ??= ProductInPackageResponse.fromProductData(
        beerSubmitData: widget.productData);
    productInPackage!.numberUnit++;
    updateInventory(-1);
    return setNumber();
  }

  void setDirectUnitNum(String numTxt) {
    if (productInPackage == null) {
      return;
    }
    final newNum = tryParseNumber(numTxt);
    if (!isHaveMultiCategory) {
      final currentNum = productInPackage!.numberUnit;
      updateInventory(currentNum - newNum);
    }
    productInPackage!.numberUnit = newNum;
    setNumber();
  }

  @override
  Widget build(BuildContext context) {
    return ProductSelectorItemUI(
      key: uiKey,
      name: name,
      imgUrl: imgUrl,
      rangePrice: rangePrice,
      unitNo: unitNo,
      addItemToPackage: addItemToPackage,
      isHaveMultiCategory: isHaveMultiCategory,
      removeItemToPackage: removeItemToPackage,
      switchToAvariable: () {
        return widget.switchToAvariable().then((value) {
          uiKey = UniqueKey();
          updateVentoryAndUnitNo();
          setState(() {});
          return value;
        });
      },
      onTxtChanged: (value) {
        setDirectUnitNum(value);
      },
      onTapOutside: removeIfEmpty,
      isAvariable: isAvariable,
      isNullUnit: isNullUnit,
      showSelectUnitModal: () {
        showAlert(context, 'Không hỗ trợ');
      },
      inventoryNum: inventoryNum,
      isEnableWarehouse: isEnableWarehouse,
    );
  }
}
