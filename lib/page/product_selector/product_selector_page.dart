import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/search_result.dart';
import 'package:sales_management/page/account/api/account_api.dart';
import 'package:sales_management/page/product_selector/api/product_selector_api.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

import '../../component/category_selector.dart';

const List<String> listCategory = ['Mỳ ăn liền', 'Đồ ăn'];

class ProductSelectorPage extends StatelessWidget {
  const ProductSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // getall().then((value) {
    //   print(value.count);
    // }).catchError((e) {
    //   print('Got error: $e');
    //   signin().then((value) {
    //     print(value.token);
    //   });
    // });
    // signin().then((value) {
    //   print(value.token);
    // });
    // me();
    return SafeArea(
        child: Scaffold(
      appBar: ProductSelectorBar(),
      body: FutureBuilder<SearchResult<BeerSubmitData>>(
        future: getall(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data!;
            final results = data.result;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: BackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategorySelector(
                    listCategory: listCategory,
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
                                  colorFilter: ColorFilter.mode(
                                    MainHighColor,
                                    BlendMode.srcIn,
                                  ),
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
                      return ProductSelectorItem();
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}

class ProductSelectorItem extends StatelessWidget {
  const ProductSelectorItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
        border: defaultBorder,
        image: DecorationImage(
          image: AssetImage(
            'assets/images/shop_logo.png',
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            margin: EdgeInsets.only(top: 12, left: 6, right: 6),
            decoration: BoxDecoration(
                color: White,
                borderRadius: defaultSquareBorderRadius,
                border: defaultBorder),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadSvg(assetPath: 'svg/minus.svg'),
                SizedBox(
                  width: 18,
                  child: TextFormField(
                    initialValue: '99',
                    maxLines: 1,
                    style: headStyleLarge,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                LoadSvg(
                  assetPath: 'svg/plus.svg',
                  colorFilter: ColorFilter.mode(
                    MainHighColor,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(
                color: Color.fromRGBO(214, 214, 214, 0.40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Mỳ hảo hảo',
                          style: subInfoStyLarge400,
                        ),
                        Text(
                          '15.000',
                          style: subInfoStyLarge600,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String txt;
  final bool isActive;
  const CategoryItem({
    super.key,
    required this.txt,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: White,
          borderRadius: defaultBorderRadius,
          border: isActive ? mainHighBorder : categoryBorder,
        ),
        child: Text(
          txt,
          style: isActive ? headStyleMediumHigh : headStyleMediumNormalLight,
        ),
      ),
    );
  }
}
