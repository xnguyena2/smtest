import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/bottom_bar_done_select_product.dart';
import 'package:sales_management/component/category_selector.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/page/product_selector/component/product_unit_selector_product_item.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalSelectProductUnitCategory extends StatefulWidget {
  final BeerSubmitData product;
  final Map<String, ProductInPackageResponse>? mapProductInPackage;
  final VoidCallbackArg<Map<String, ProductInPackageResponse>> onDone;
  final ReturnCallbackArgAsync<BeerSubmitData, bool> swithAvariable;
  final VoidCallback onRefreshData;
  const ModalSelectProductUnitCategory({
    super.key,
    required this.onDone,
    required this.product,
    this.mapProductInPackage,
    required this.swithAvariable,
    required this.onRefreshData,
  });

  @override
  State<ModalSelectProductUnitCategory> createState() =>
      _ModalSelectProductUnitCategoryState();
}

class _ModalSelectProductUnitCategoryState
    extends State<ModalSelectProductUnitCategory> {
  late final List<BeerSubmitData> listAllProduct;
  late List<BeerSubmitData> listProduct;
  late final Map<String, ProductInPackageResponse> mapProductInPackage =
      widget.mapProductInPackage ?? {};

  late final firstUnitCate = [
    'Tất cả',
    ...widget.product.productUnitCatPattern.items[0].items.values.toList()
  ];
  List<String> listCateSelected = [];

  late final ReturnCallbackArgAsync<BeerSubmitData, bool> swithAvariable =
      widget.swithAvariable;

  double totalPrice = 0;
  int numItem = 0;

  bool mustRefreshData = false;

  void updatePrice() {
    totalPrice = 0;
    numItem = 0;
    mapProductInPackage.values.forEach((element) {
      numItem += element.numberUnit;
      totalPrice += element.totalPriceDiscount;
    });
  }

  void addOrUpdateProduct(ProductInPackageResponse productInPackageResponse) {
    _addProduct(productInPackageResponse);
    updatePrice();
    setState(() {});
  }

  void _addProduct(ProductInPackageResponse productInPackageResponse) {
    final productUnit = productInPackageResponse.beerSubmitData?.firstOrNull;
    if (productUnit == null) {
      return;
    }
    final unitId = productUnit.beerUnitSecondId;
    if (productInPackageResponse.numberUnit <= 0) {
      mapProductInPackage.remove(unitId);
      return;
    }
    if (mapProductInPackage.containsKey(unitId)) {
      return;
    }
    mapProductInPackage[unitId] = productInPackageResponse;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listAllProduct = listProduct = widget.product.flatUnit();
    updatePrice();
  }

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: widget.product.name,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Row(
              children: [
                CategorySelector(
                  listCategory: firstUnitCate,
                  multiSelected: false,
                  onChanged: (listCategorySelected) {
                    listCateSelected = listCategorySelected;
                    final String? firstCat = listCategorySelected.firstOrNull;
                    if (firstCat == null || firstCat == 'Tất cả') {
                      listProduct = listAllProduct;
                      setState(() {});
                      return;
                    }
                    listProduct = listAllProduct
                        .where((element) =>
                            element.isContainUnitCategory(listCateSelected))
                        .toList();

                    setState(() {});
                  },
                  itemsSelected: listCateSelected,
                  firstWidget: LoadSvg(assetPath: 'svg/grid_horizontal.svg'),
                  isFlip: false,
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 20, top: 10),
                color: BackgroundColor,
                child: selectProduct(),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          BottomBarDoneSelectProduct(
            numItem: numItem,
            done: () {
              Navigator.pop(context);

              widget.onDone(mapProductInPackage);
              if (mustRefreshData) {
                widget.onRefreshData();
              }
            },
            totalPriceFormat: MoneyFormater.format(totalPrice),
          ),
        ],
      ),
    );
  }

  GridView selectProduct() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: listProduct.length,
      itemBuilder: (context, index) {
        BeerSubmitData productData = listProduct[index];
        final productUnitID = productData.firstOrNull?.beerUnitSecondId;
        if (productUnitID == null) {
          return const SizedBox();
        }
        final productPackage = mapProductInPackage[productUnitID];
        return ProductUnitSelectorItem(
          key: ValueKey(productUnitID),
          productData: productData,
          updateNumberUnit: (productInPackageResponse) {
            addOrUpdateProduct(productInPackageResponse);
          },
          onChanged: null,
          mapProductInPackage:
              productPackage == null ? null : {productUnitID: productPackage},
          switchToAvariable: () {
            mustRefreshData = true;
            return swithAvariable(productData);
          },
        );
      },
    );
  }
}
