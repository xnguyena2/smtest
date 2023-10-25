import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/search_result.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/product_selector/api/product_selector_api.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bar.dart';
import 'package:sales_management/page/product_selector/component/product_selector_product_item.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/utils.dart';

import '../../component/category_selector.dart';

class ProductSelectorPage extends StatefulWidget {
  final PackageDataResponse packageDataResponse;
  const ProductSelectorPage({super.key, required this.packageDataResponse});

  @override
  State<ProductSelectorPage> createState() => _ProductSelectorPageState();
}

class _ProductSelectorPageState extends State<ProductSelectorPage> {
  late Future<BootStrapData?> loadConfig;
  late final List<BeerSubmitData> listAllProduct;
  late List<BeerSubmitData> listProduct;
  late final List<String> listCategory;

  List<String> listCateSelected = ['Tất cả'];

  Future<BootStrapData?> getAllProduct() async {
    var box = Hive.box(hiveSettingBox);
    BootStrapData? config = box.get(hiveConfigKey);

    final results = config?.products ?? [];
    final listCategoryContent = config?.deviceConfig?.categorys ?? '';
    listCategory = ['Tất cả'];

    final List<String> allCat = List.from(jsonDecode(listCategoryContent));
    listCategory.addAll(allCat);

    listAllProduct = flatten<BeerSubmitData>(results.map(
      (e) {
        return e.flatUnit();
      },
    ));
    listAllProduct.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    listProduct = listAllProduct;
    return config;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadConfig = getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ProductSelectorBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        onChanged: (searchTxt) {
          listProduct = listAllProduct
              .where((element) => element.searchMatch(searchTxt))
              .toList();
          setState(() {});
        },
      ),
      body: FetchAPI<BootStrapData?>(
        future: loadConfig, //getall(),
        successBuilder: (BootStrapData? data) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: BackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategorySelector(
                    listCategory: listCategory,
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
                              element.isContainCategory(listCateSelected))
                          .toList();
                      setState(() {});
                    },
                    isFlip: true,
                    itemsSelected: listCateSelected,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 120,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: listProduct.length + 1,
                    itemBuilder: (context, index) {
                      if (index == listProduct.length)
                        return Container(
                          decoration: BoxDecoration(
                            color: White,
                            borderRadius: defaultBorderRadius,
                            border: defaultBorder,
                          ),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                LoadSvg(
                                  assetPath: 'svg/plus.svg',
                                  color: MainHighColor,
                                ),
                                Positioned(
                                  bottom: -25,
                                  child: Text(
                                    'Thêm sản phẩm',
                                    style: subInfoStyLargeHigh400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      BeerSubmitData productData = listProduct[index];
                      final productUnitID =
                          productData.listUnit?.firstOrNull?.beerUnitSecondId;
                      return ProductSelectorItem(
                        productData: productData,
                        productInPackageResponse: productUnitID == null
                            ? null
                            : widget
                                .packageDataResponse.productMap[productUnitID],
                        updateNumberUnit: (productInPackageResponse) {
                          widget.packageDataResponse
                              .addProduct(productInPackageResponse);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
