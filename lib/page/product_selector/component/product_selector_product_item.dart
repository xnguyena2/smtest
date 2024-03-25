import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/helper/backup_restore.dart';
import 'package:sales_management/page/product_info/api/product_info_api.dart';
import 'package:sales_management/page/product_selector/component/modal_select_product_unit.dart';
import 'package:sales_management/page/product_selector/component/modal_update_inventory.dart';
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
  late final bool isHaveMultiCategory;

  late final bool isEnableWarehouse = widget.productData.isEnableWarehouse;

  Key uiKey = UniqueKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    name = widget.productData.name;
    imgUrl = widget.productData.getFristLargeImg;

    isHaveMultiCategory = widget.productData.isHaveMultiCategory;
    if (!isHaveMultiCategory) {
      productInPackage = mapProductInPackage?.entries.firstOrNull?.value;
    }
    rangePrice = widget.productData.getRangePrice;
    updateInVentoryAndUnitNo();
  }

  void updateInVentoryAndUnitNo() {
    isAvariable = widget.productData.isAvariable;
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
    if (!isHaveMultiCategory) {
      updateInventory(1);
    }
    return setNumber();
  }

  int addItemToPackage() {
    productInPackage ??= ProductInPackageResponse.fromProductData(
        beerSubmitData: widget.productData);
    productInPackage!.numberUnit++;
    if (!isHaveMultiCategory) {
      updateInventory(-1);
    }
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
    switchProductToAvariable() async {
      bool isOkPressed = false;
      await showDefaultDialog(
          context, 'Xác nhận thay đổi!', 'Sản phẩm đã có hàng lại?',
          onOk: () async {
        isOkPressed = true;
      }, onCancel: () {});
      if (isOkPressed) {
        if (widget.productData.isEnableWarehouse &&
            widget.productData.getInventory <= 0) {
          var inventoryNum = widget.productData.getInventory;
          await showDefaultModal(
            context: context,
            content: ModalUpdateInventory(
              onDone: (inventoryNo) {
                inventoryNum = inventoryNo;
              },
              inventoryNum: inventoryNum,
            ),
          );
          if (inventoryNum <= 0) {
            return false;
          }
          widget.productData.setInventory = inventoryNum;
        } else {
          widget.productData.changeStatus(true);
        }
        LoadingOverlayAlt.of(context).show();
        createProduct(widget.productData).then((value) {
          LoadingOverlayAlt.of(context).hide();
          isAvariable = widget.productData.isAvariable;
          widget.onChanged?.call(widget.productData);
          updateInVentoryAndUnitNo();
          uiKey = UniqueKey();
          setState(() {});
        }).onError((error, stackTrace) {
          LoadingOverlayAlt.of(context).hide();
          widget.productData.changeStatus(false);
          showAlert(
              context, 'Lỗi hệ thống không thể cập nhật sản phẩm!!!');
        });
      }
      return isAvariable;
    }

    switchProductUnitToAvariable(BeerSubmitData productUnit) async {
      bool isUnitAvariable = false;
      bool isOkPressed = false;
      await showDefaultDialog(
          context, 'Xác nhận thay đổi!', 'Sản phẩm đã có hàng lại?',
          onOk: () async {
        isOkPressed = true;
      }, onCancel: () {});
      if (isOkPressed) {
        if (productUnit.isEnableWarehouse && productUnit.getInventory <= 0) {
          var inventoryNum = productUnit.getInventory;
          await showDefaultModal(
            context: context,
            content: ModalUpdateInventory(
              onDone: (inventoryNo) {
                inventoryNum = inventoryNo;
              },
              inventoryNum: inventoryNum,
            ),
          );
          if (inventoryNum <= 0) {
            return false;
          }
          productUnit.setInventory = inventoryNum;
          isUnitAvariable = true;
        } else {
          isUnitAvariable = true;
          productUnit.changeFirstUnitStatus(isUnitAvariable);
        }
        LoadingOverlayAlt.of(context).show();
        await createProduct(widget.productData).then((value) {
          LoadingOverlayAlt.of(context).hide();
          widget.onChanged?.call(widget.productData);
        }).onError((error, stackTrace) {
          LoadingOverlayAlt.of(context).hide();
          isUnitAvariable = false;
          productUnit.changeFirstUnitStatus(isUnitAvariable);
          showAlert(
              context, 'Lỗi hệ thống không thể cập nhật sản phẩm!!!');
        });
      }
      return isUnitAvariable;
    }

    showSelectUnitModal() async {
      BackupRestore action = BackupRestore<List<BeerUnit>?, Map<String, int>?>(
        backup: (listBeerUnit) {
          final backupInventoryNum = listBeerUnit == null
              ? null
              : Map.fromEntries(listBeerUnit.map(
                  (e) => MapEntry(e.beerUnitSecondId, e.getInventoryNo),
                ));
          return backupInventoryNum;
        },
        restore: (img) {
          if (widget.productData.listUnit != null) {
            for (var element in widget.productData.listUnit!) {
              final value = img![element.beerUnitSecondId];
              if (value == null) {
                continue;
              }
              element.inventory_number = value;
            }
          }
        },
        mainAction: () async {
          bool shouldRestore = true;
          final clone = mapProductInPackage == null
              ? null
              : Map.fromEntries(mapProductInPackage!.entries
                  .map((e) => MapEntry(e.key, e.value.clone())));
          await showDefaultModal(
            context: context,
            content: ModalSelectProductUnitCategory(
              product: widget.productData,
              mapProductInPackage: clone,
              swithAvariable: switchProductUnitToAvariable,
              onDone: (Map<String, ProductInPackageResponse> maps) {
                shouldRestore = false;
                mapProductInPackage = maps;
                updateInVentoryAndUnitNo();
                uiKey = UniqueKey();
                widget.updateListNumberUnit?.call(maps.values.toList());
                setState(() {});
              },
            ),
          );
          return shouldRestore;
        },
      );
      action.action(widget.productData.listUnit);
    }

    return ProductSelectorItemUI(
      key: uiKey,
      name: name,
      imgUrl: imgUrl,
      rangePrice: rangePrice,
      unitNo: unitNo,
      addItemToPackage: addItemToPackage,
      isHaveMultiCategory: isHaveMultiCategory,
      removeItemToPackage: removeItemToPackage,
      switchToAvariable: switchProductToAvariable,
      onTxtChanged: (value) {
        setDirectUnitNum(value);
      },
      onTapOutside: removeIfEmpty,
      isAvariable: isAvariable,
      isNullUnit: false,
      showSelectUnitModal: showSelectUnitModal,
      inventoryNum: inventoryNum,
      isEnableWarehouse: (isHaveMultiCategory && inventoryNum > 0) ||
          (!isHaveMultiCategory && isEnableWarehouse),
    );
  }
}
