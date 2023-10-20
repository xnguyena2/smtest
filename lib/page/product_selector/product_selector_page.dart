import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/search_result.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/product_selector/api/product_selector_api.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bar.dart';
import 'package:sales_management/page/product_selector/component/product_selector_product_item.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/utils.dart';

import '../../component/category_selector.dart';

const List<String> listCategory = ['Tất cả', 'Mỳ ăn liền', 'Đồ ăn'];

class ProductSelectorPage extends StatelessWidget {
  final PackageDataResponse packageDataResponse;
  const ProductSelectorPage({super.key, required this.packageDataResponse});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ProductSelectorBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: FetchAPI<SearchResult<BeerSubmitData>>(
        future: getall(),
        successBuilder: (SearchResult<BeerSubmitData> data) {
          final results = flatten<BeerSubmitData>(data.result.map(
            (e) {
              return e.flatUnit();
            },
          ));
          results.sort(
            (a, b) => a.name.compareTo(b.name),
          );
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: BackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategorySelector(
                    listCategory: listCategory,
                    multiSelected: true,
                    onChanged: (listCategorySelected) {},
                    isFlip: true,
                    itemsSelected: [],
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
                    itemCount: results.length + 1,
                    itemBuilder: (context, index) {
                      if (index == results.length)
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
                      BeerSubmitData productData = results[index];
                      final productUnitID =
                          productData.listUnit?.firstOrNull?.beerUnitSecondId;
                      return ProductSelectorItem(
                        productData: productData,
                        productInPackageResponse: productUnitID == null
                            ? null
                            : packageDataResponse.productMap[productUnitID],
                        updateNumberUnit: (productInPackageResponse) {
                          packageDataResponse
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
